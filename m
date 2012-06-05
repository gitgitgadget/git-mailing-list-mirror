From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 4/4] Add cat-blob report pipe from fast-import to remote-helper.
Date: Wed, 06 Jun 2012 00:16:25 +0200
Message-ID: <5801019.gWQEmI8V81@flobuntu>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <CAFfmPPP1koMnYBFbgHt0MGr77okjL5OdAh-TMxFTevj+mDbOZQ@mail.gmail.com> <20120605081402.GF25809@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: David Michael Barr <davidbarr@google.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 00:17:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc24Q-0000FJ-HU
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 00:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab2FEWR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 18:17:26 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35074 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575Ab2FEWRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 18:17:25 -0400
Received: by weyu7 with SMTP id u7so3908746wey.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 15:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=/LwUqDGVwldFKCsShYLIOVQ2aQq2bfJqlZhdGYOThj0=;
        b=SS8fP0o/bZOzyMjsLSbyLiwt/gh6TLbkptPCgeCMDsY6fDx/Efek/wkwQvRxh/Q8vc
         b6SllyGUqHVkkC47uCKNgdQBjRI40fm0wadmKV0aOtNCmovtNmNSYwvVav7ZzH7UQ7JM
         MJFL20kPUclmjMVOkX6Pdua/oFWUFoSInQobUjiXymE7qpVHxzoGJ3TqbVB/lirTsMFl
         RZnWoS8k4jr7a4T2TYr7ojt6e5idjKyvboWyB+GqYTLbBiYO6OEZjXrVHY61olcz68gI
         ZmOjHfOGZFwhlNcUM/mGSvC2qlDsD/sqew0Gh8pBILGI1092qOdfcVOsTb5hCGU6m2QE
         sRIg==
Received: by 10.216.228.98 with SMTP id e76mr13944881weq.150.1338934644095;
        Tue, 05 Jun 2012 15:17:24 -0700 (PDT)
Received: from flobuntu.localnet (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id e20sm426740wiv.7.2012.06.05.15.17.21
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Jun 2012 15:17:23 -0700 (PDT)
User-Agent: KMail/4.8.3 (Linux/3.2.0-24-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <20120605081402.GF25809@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199294>

On Tuesday 05 June 2012 04:14:02 Jeff King wrote:
> Is there a reason that the patch unconditionally creates the pipe in
> get_helper? I.e., isn't it specific to the get_importer code path? It
> feels a little hacky to have it infect the other code paths.

I agree, it's a bit hacky. For me as a newbee, it was just a way to make fast-
import have the pipe it needs. I didn't know about the history of the 
preexec_cb as a fix for a bug in less.

The pipe is created unconditionally, because at the fork-time of the remote-
helper it is not known whether the import command will be used later together 
with fast-import, or not. (and later, there's no way, I think).
Helpers that don't use the pipe could simply ignore it.

--
Florian Achleitner
