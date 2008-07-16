From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [PATCH] Fix buffer overflow in git-grep
Date: Wed, 16 Jul 2008 18:33:37 +0400
Message-ID: <37fcd2780807160733o156e49c6m51314ff18764ccd5@mail.gmail.com>
References: <1216203345-18233-1-git-send-email-dpotapov@gmail.com>
	 <alpine.DEB.1.00.0807161232110.8503@eeepc-johanness>
	 <20080716115420.GD2925@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 16:34:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ85V-0000EW-SL
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 16:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbYGPOdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 10:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755130AbYGPOdj
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 10:33:39 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:63688 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415AbYGPOdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 10:33:38 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5683861wfd.4
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4KTTuIdVj2erbh0KYNkOG7GMCKBEudKKDL8O/TEufcM=;
        b=AApzvLgmQRUPKp/Lrxu/kpixcAyDqlVCIrPL4zKqPNXpnx8tnsJja4jybZn9S9OpFg
         qQ0P8i5jYcGIVmlR2NID6vi8oBcOg/QQgtl3YExoe6dgxAVygfn6w47GhKguRiKAKaSy
         PxQifrn50ggNwN4oN1JRkzoQbRAjVW3oZBCQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aAfZr3t8UovomexLNbUMTMRAprmT8MsbpMM7O9k6zSXanMIuzM6B7QR9nAIUhPGYhs
         ebP2s0PRn2TguPt6d5UEGTf98vo/n8hAT8V+i7G5MPClJQOdd2FkcFPHPs4e13TarRhc
         qwRW8ahCCQHo5/tfq2xXplEO6JxqT1tzlpPFo=
Received: by 10.142.174.8 with SMTP id w8mr76174wfe.4.1216218817720;
        Wed, 16 Jul 2008 07:33:37 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Wed, 16 Jul 2008 07:33:37 -0700 (PDT)
In-Reply-To: <20080716115420.GD2925@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88683>

On Wed, Jul 16, 2008 at 3:54 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
>
> For instance, git show will show you nothing at all and exit with 0.
> The same problem with git whatchanged. The whole history mysteriously
> disappeared at that commit, and git whatchanged exited with 0 without
> any error or warning... Though git log will show you all history, but
> if you run it with -p then it will also exit with zero at this commit
> silently like previously history do not exist at all.

It turned out that git actually crashed while doing diff, but because it
was a forked process, the parent exited normally with code 0. I wonder
should not the parent process to exit with a non-zero code if the child
died by SIGSEG or another signal?

Dmitry
