From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH for next] insert missing newline in a diagnostic
Date: Tue, 31 Aug 2010 19:17:29 -0500
Message-ID: <20100901001729.GG6747@burratino>
References: <87iq2s4ewn.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Sep 01 02:19:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqb2x-0005jh-6d
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 02:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab0IAATR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 20:19:17 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50801 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab0IAATQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 20:19:16 -0400
Received: by qwh6 with SMTP id 6so5771508qwh.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 17:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3Ry5Ka0y0Xbf2RxXeCIcC+Z7KtDJRiGJqOdFJFBTnf0=;
        b=d+0eVuI4vPmykkgjXcoAm1ZmGMwGwlaSdOf/D1tOXKGbqBY4HZ/qCq37M2R2mFiAiY
         8E/3lJBFXk5+SSyRi0Heb8B2hz24I76f+Z6fs5Ea4JU3aGrADYw8FkXK58bMPqp8ZF/C
         DfiqTpR092OlrRGrl2B5Z68zAS8jOp0QyWsXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KcH4vMCLuFGdXObF0yk5pIoJHGXWqsjAisLvTQS3DJ4RUBh/PLRGVVzDw7G69Rrklz
         MisbuB6e+ZMgvNBQet4beH4pSib1b2TXiHxUo8gXz9udyX6gVnLF9qZI1/2PurXEx5Jp
         f1O7MBYZzwKJZ/WjkyWgSV7WVIRMNrX2J2ZLE=
Received: by 10.229.183.20 with SMTP id ce20mr1024184qcb.203.1283300355786;
        Tue, 31 Aug 2010 17:19:15 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t4sm10379445qcs.28.2010.08.31.17.19.13
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 17:19:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87iq2s4ewn.fsf@meyering.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154999>

(+cc: Matthieu, Junio)

Hi Jim,

Jim Meyering wrote:

> When merging, I would get a message like this:
> 
>   error: The following untracked working tree files would be overwritten by merge:
>   FILE_NAMEPlease move or remove them before you can merge.
> 
> This change inserts the newline after FILE_NAME.

I fear it is more complicated.  With your patch, in some situations
(e.g., when running t7609-merge-co-error-msgs.sh) I get a leading tab
and extra newline:

 error: The following untrack...
	FILE_NAME

 Please move or remove them before you can merge.

In unpack-trees, display_error_msgs() prints the version with a tab
but you are getting the message from add_rejected_path which suggests
to me that o->show_all_errors is unset.

Was there some other error before then?

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/152965/focus=153211
