From: Julien Cretel <j.cretel@umail.ucc.ie>
Subject: Re: Should "git log --decorate" indicate whether the HEAD is detached?
Date: Mon, 16 Feb 2015 23:40:27 +0000
Message-ID: <CACdBeKnWJvUmFaHNrzcX7LtovOLu3PFaeTyoUAUeC7wmYUboDg@mail.gmail.com>
References: <CACdBeKmNazMtzK4hdd7WXMPDr7HdPe+EFpyd3M-TPBAUEY+HpA@mail.gmail.com>
	<xmqqa90d4fdp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 00:40:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNVHG-0007Dt-Vm
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 00:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbbBPXk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 18:40:28 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35357 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbBPXk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 18:40:27 -0500
Received: by mail-yk0-f169.google.com with SMTP id 79so14480125ykr.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 15:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+RmYtS65iIEXfZv9M9bA4WMF00KuWV7LUuslOUTsszE=;
        b=hoF5MF4VlSDponVrgGLFqxcSRdi53n1t/TmSMlDqPUPzEujjf/wN5KmT9sZcheBmYI
         bJNT+DUVEZbDxyhWqt4TQ3qOAcMvcZUDjtrlOLSkCNXt5GgLoYc69TI3TQPMhboKi+iW
         NvSo4BTCAgg96D3zcKe4/ou0N8eb2+AW+2mYs86lSvJEfea6UtY30YyssG6EyMfUvZQm
         MhBMaVswyiwdpRt9LVQ+1kTsgR5RUtlhnB2ruWEbh2aoujDynLIa5jQl9ivQjxmjxzSF
         WChOoU8QtA8SsuEzFFX7Ed/Gw4JnTKxgUgSzTW4cdpCo/eTUMqL6jDxEveZWiC/rPPDG
         Vg6g==
X-Gm-Message-State: ALoCoQmMuGzOJhv8KHYp65XjyDlDlq0FICZHBaTxH8H6dkDSj+fF8P4fOvqLPXX9HUiTEVNpAJhd
X-Received: by 10.170.220.197 with SMTP id m188mr84293ykf.58.1424130027108;
 Mon, 16 Feb 2015 15:40:27 -0800 (PST)
Received: by 10.170.36.197 with HTTP; Mon, 16 Feb 2015 15:40:27 -0800 (PST)
In-Reply-To: <xmqqa90d4fdp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263926>

On Mon, Feb 16, 2015 at 11:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Julien Cretel <j.cretel@umail.ucc.ie> writes:
>
>> As of Git 2.3.0, the output of "git log --decorate" is ambiguous as to
>> whether the HEAD is detached or not.
>
> It sounds as if you are reporting some regression, but has any
> version of Git ever done so, or is this just a new feature that
> does not exist yet?

Apologies; I should have explained myself better. I'm not reporting a
regression;
as far as I can tell, "git log --decorate" has always been ambiguous
in that way.

>
>> More specifically, consider the following output of "git log --decorate":
>>
>>     4d860e9 (HEAD, master, dev) Remove trailing whitespace
>>
>> Whether the HEAD is attached to master or detached, the output is the same.
>> Could/should "git log --decorate" be modified to provide this information?
>> Perhaps something along the lines of
>>
>>     4d860e9 (HEAD -> master, dev) Remove trailing whitespace
>>
>> or
>>
>>     4d860e9 (HEAD = master, dev) Remove trailing whitespace
>>
>
> I personally do not see a need for such a differenciation.  Why does
> one even need to know, and is it worth the cost of computing at the
> runtime?

I believe the "--decorate" flag to be quite popular. I personally like to run
"git log --decorate --graph --oneline --all" to quickly get an idea of the state
of a repo. In my experience, many users do the same, to the point that they
feel the need to define an alias for this command; see the top answers to
http://stackoverflow.com/q/1057564/2541573.

My problem with the current output of "git log --decorate" is the asymmetry,
so to speak. If the HEAD is detached but pointing at a commit that isn't any
branch's tip, then the user can be sure the HEAD detached; however, if at
least one branch points to the current commit, there is no way to tell.

I must admit I haven't given much thought about the cost involved, but I can't
imagine performance would take a big hit. Would it?

>
> Most of the time when I am on detached HEAD it is either a few
> commits behind a tip, or a few commits ahead of a tip.
