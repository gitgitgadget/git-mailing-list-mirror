From: Bryan Turner <bturner@atlassian.com>
Subject: Re: GIT Hooks and security
Date: Sat, 26 Oct 2013 11:17:33 +1100
Message-ID: <CAGyf7-HCEQy2hUnc6UvABDrwYatoUEiPnpXo-e9_8wtbhvN0mw@mail.gmail.com>
References: <CA+nXgrUZk=_wtQ2yQnxwCZ3Mazdz=ZH2FJV+V92PVa0a4+A1hQ@mail.gmail.com>
	<xmqqwql1hub6.fsf@gitster.dls.corp.google.com>
	<CA+nXgrUcpfya+rTPzfRafzJbK1khNqtz-HsaKeGfdA86AepKEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Users <git@vger.kernel.org>
To: Olivier Revollat <revollat@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 02:17:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZrZg-00053L-N2
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 02:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab3JZARf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 20:17:35 -0400
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:50039 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752877Ab3JZARe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Oct 2013 20:17:34 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]) (using TLSv1) by na3sys009aob114.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUmsKHhvmhKVVliKwWwTh75sCrRtMYtwR@postini.com; Fri, 25 Oct 2013 17:17:34 PDT
Received: by mail-oa0-f50.google.com with SMTP id j6so1662598oag.9
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 17:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=x/CvwkqoFDn6VRURAm0nYwiPEjoKgt+Bqpbxdl9Y3Kk=;
        b=jk9N4qmeoqunMkmvnASNYQ+KQl290MMgEz0HxFkCyZ48jKD4dUDAPm/C2tHDqAsmrh
         3mvDlWwEU0gJWNxyOQT7A6kyFOmAqm6jTSNfABU6ckSCBUM06HQuR077RpMCEAvBYk76
         9Op2y7Dre6OVYoordLas0nXYCRvhxUG/L4QyYoQ0hNh9EGWiHSt4tGiUvRwyBL09LGLy
         d2ffRoIEpjOpHM+4HdC2yK9MBsfLizpvCsZyDXtCLA7fV8NWTOzuOhmkPLycktCzktIK
         IJL7gsY/Tmn2YB5d16NX5Uj5X9IDgzasM8zcOBrcYrSgtAHqmywk1ymZko28ohbkaX0m
         bWRQ==
X-Gm-Message-State: ALoCoQn46YavJEw0bBiY988FSloyB0nPOYdUArsbZLKHMOd5dd5TMwBN086M6GUOumyl1/FqNQxr0/9mg0/NsOzktHOle4vRCIfRMiXAiDhAFb8XstjdmTuGJY1BsvcH7YtOxqGagoeA4SmYAcYJlwYL3zhGLaAV0Q==
X-Received: by 10.182.102.2 with SMTP id fk2mr36481obb.69.1382746653791;
        Fri, 25 Oct 2013 17:17:33 -0700 (PDT)
X-Received: by 10.182.102.2 with SMTP id fk2mr36469obb.69.1382746653560; Fri,
 25 Oct 2013 17:17:33 -0700 (PDT)
Received: by 10.182.92.114 with HTTP; Fri, 25 Oct 2013 17:17:33 -0700 (PDT)
In-Reply-To: <CA+nXgrUcpfya+rTPzfRafzJbK1khNqtz-HsaKeGfdA86AepKEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236727>

No, the .git/hooks directory in your clone is created from your local
templates, installed with your Git distribution, not the remote hooks.
On Linux distributions, these templates are often in someplace like
/usr/share/git-core/templates (for normal packages), and on Windows
with msysgit they are in share\git-core\templates under your
installation directory. If you look in this directory you will see a
hooks directory containing the sample hooks.

Hooks from a remote repository are never cloned. As far as I'm aware,
nothing from the .git directory (aside from refs and packs, of course)
is cloned, including configuration. Your .git directory after a clone
is completely new, assembled from scratch. There's nothing in the Git
wire protocol (currently) for moving other data like configuration or
hooks, and this sort of malicious code injection is one of the reasons
I've seen discussed on the list for why that's the case.

Hope this helps,
Bryan Turner


On 26 October 2013 09:25, Olivier Revollat <revollat@gmail.com> wrote:
>
> But when someone do a "clone" he don't have .git/hooks directory
> downloaded to his local computer ? I thought so ...
>
> 2013/10/26 Junio C Hamano <gitster@pobox.com>:
> > Olivier Revollat <revollat@gmail.com> writes:
> >
> >> I was wondering : What if I had a "malicious" GIT repository who can
> >> "inject" code  via git hooks mechanism : someone clone my repo and
> >> some malicious code is executed when a certain GIT hook is triggered
> >> (for example on commit ("prepare-commit-msg' hook))
> >
> > In that somebody else's clone, you will not have _your_ malicious
> > hook installed, unless that cloner explicitly does something stupid,
> > like copying that malicious hook.
>
>
>
> --
> Mathematics is made of 50 percent formulas, 50 percent proofs, and 50
> percent imagination.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
