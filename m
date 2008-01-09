From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: [PATCH] Simplified the invocation of command action in submodule
Date: Wed, 9 Jan 2008 11:24:23 +0100
Message-ID: <8c5c35580801090224l1e30df6cw5d3fefe99c0cdd7@mail.gmail.com>
References: <1199851140-31853-1-git-send-email-imyousuf@gmail.com>
	 <47848CDD.7050806@viscovery.net>
	 <7bfdc29a0801090151k22d3cd5aqedb0d4860868d4d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org,
	gitster@pobox.com
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 11:24:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCY7F-0004tD-M3
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 11:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbYAIKYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 05:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbYAIKYa
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 05:24:30 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:35983 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbYAIKY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 05:24:29 -0500
Received: by wa-out-1112.google.com with SMTP id v27so322887wah.23
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 02:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=2II5iRby0I14K+5qchwwCMDrxjqQVbBRGjL+xiZTUgk=;
        b=fRy8bq1m9Ap+/YYUoaEt4EaVOjLTiAoqR3J/XNFmAv18RwK6rP/yzQQJd1WbqjZ7wvW4vxerlq3NWNh3iRhZOnaoJv58nAM6jUdFVPv27weMygzcIxSCLU58Tr+M/r11oT9Ew/RLeJ6LP1WDuhaDqBl5NLEYIDPSlH3xQs5+bjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=vApSP6bn1WW+EnETZpj8+QdcUypwB6UluGEEBeO/sxGm/EcEQWiyaRDcFatNFAfbRySPtwrh+ne6Vp+8kVMo6shQrH6a1Kj9E3qCfUDjo5Bs+97LIzVv+hX1jpxF+G5MScptI4W13JFez0ZG8ldXBRwyDfwEWU+jiMPjhMJHvXg=
Received: by 10.115.88.1 with SMTP id q1mr646515wal.64.1199874268824;
        Wed, 09 Jan 2008 02:24:28 -0800 (PST)
Received: by 10.114.241.8 with HTTP; Wed, 9 Jan 2008 02:24:23 -0800 (PST)
In-Reply-To: <7bfdc29a0801090151k22d3cd5aqedb0d4860868d4d9@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 691d8533463f7ae4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69977>

On Jan 9, 2008 10:51 AM, Imran M Yousuf <imyousuf@gmail.com> wrote:
> On Jan 9, 2008 2:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> >
> > - Previously, passing --cached to add, init, or update was an error, now
> > it is not.
>
> The usage statement and this behaviour is rather contradicting. The
> usage says that --cached can be used with all commands; so I am not
> sure whether using --cached with add should be an error or not. IMHO,
> if the previous implementation was right than the USAGE has to be
> changed, and if the previous implementation was incorrect, than if the
> default command is set to status than current implementation is right.
>
> I would like to get comment on this until I fix the patch and resend it.

--cached only makes sense for the status subcommand, so the
usage/manpage probably should have looked like this (except for the
whitespace mangling...):

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index cffc6d4..331e806 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -10,7 +10,10 @@ SYNOPSIS
 --------
 [verse]
 'git-submodule' [--quiet] [-b branch] add <repository> [<path>]
-'git-submodule' [--quiet] [--cached] [status|init|update] [--] [<path>...]
+'git-submodule' [--quiet] [--cached] [status] [--] [<path>...]
+'git-submodule' [--quiet] init [--] [<path>...]
+'git-submodule' [--quiet] update [--] [<path>...]
+


 COMMANDS
-- 
1.5.3.7.1141.g4eb39
