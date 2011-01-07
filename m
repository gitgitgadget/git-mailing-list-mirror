From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] [PATCH/RFC] alias: use run_command api to execute aliases
Date: Fri, 7 Jan 2011 15:24:25 +0100
Message-ID: <AANLkTi=6wG6khBAqLA8nki5-wbxQB-oYUAgMSqT-egpt@mail.gmail.com>
References: <1294341187-3956-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1101070216390.1542@bonsai2>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 07 15:25:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbDFN-00045E-0s
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 15:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab1AGOYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 09:24:48 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48895 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab1AGOYr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 09:24:47 -0500
Received: by fxm20 with SMTP id 20so16952829fxm.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=N0sBOdQOaYxz63bvyMzGX3fMLBA07+mF6RkQkB5/974=;
        b=v7UxJ2eCikgTtWsADSWPZI7gRXH755eLFtnmwM7DS1sNKYYyImY+6Z/eIImmFsUx7V
         6cDNpbBDQx4kNx5J+pC/NhdkZ8JC07Dv5LKGVlpTA/EBvWd47JWt/+pKlj0RDapGgmTs
         1te+VTnKEn/5BY0ovk3ErSagePbZ0s+TxsssU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=hkR8UQdOiRKdF4EMQtnbCSd+wHhCXIgE3aAFWgH+GK4C1albLYoFgr9NVWFvqbnegm
         T+pXzAa9R9CWtxXls8Kn+aLHESLyVOkDfTwzM+6pnaNHC+kL10golC0X2gQY6pc5K8Jm
         fI4zXonSf1QWD83lX/DhK+sVbp8AR3V2fOnx4=
Received: by 10.223.96.68 with SMTP id g4mr3665801fan.33.1294410286095; Fri,
 07 Jan 2011 06:24:46 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Fri, 7 Jan 2011 06:24:25 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1101070216390.1542@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164713>

On Fri, Jan 7, 2011 at 2:17 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 6 Jan 2011, Erik Faye-Lund wrote:
>
>> On Windows, system() executes with cmd.exe instead of /bin/sh. This
>> means that aliases currently has to be batch-scripts instead of
>> bourne-scripts. On top of that, cmd.exe does not handle single quotes,
>> which is what the code-path currently uses to handle arguments with
>> spaces.
>>
>> To solve both problems in one go, use run_command_v_opt() to execute
>> the alias. It already does the right thing prepend "sh -c " to the
>> alias.
>
> Would this not break setups where aliases were defined to execute batch
> scripts?
>
> If this is true, I'm of two minds here.
>

It would indeed, but I wouldn't worry TOO much about it. We've clearly
told the users that Git for Windows is a tool that you have to be
willing to work on to use.

But I'm kind of of two minds here myself, but for a slightly different
reason: I think Git for Windows SHOULD use cmd.exe to execute scripts.
We should be able to lose the msys-environment and still have the
basic functionality working. In that sense, this is a step in the
wrong direction. But I'd rather have all code use the same code-path
to execute scripts, and make a bit switch to cmd.exe together with
porting all supplied scripts to batch-files some time in the future.
