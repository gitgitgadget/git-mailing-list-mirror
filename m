From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: v1.7.0-rc0 shows lots of "unable to find <sha1>" on git-stash
Date: Sun, 31 Jan 2010 19:21:10 +0000
Message-ID: <57518fd11001311121wf749cf3nd2b7ae55f3ea2e61@mail.gmail.com>
References: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com> 
	<7vzl3wiz59.fsf@alter.siamese.dyndns.org> <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com> 
	<4B642696.2070501@web.de> <57518fd11001300523xf7d931by254581c8494171af@mail.gmail.com> 
	<4B643DEF.8010809@web.de> <57518fd11001300836v7f21a8a9qc09953d9091a4513@mail.gmail.com> 
	<7v8wbfnyz9.fsf@alter.siamese.dyndns.org> <7vvdejmjaj.fsf@alter.siamese.dyndns.org> 
	<57518fd11001311116t1bde882dub1dd3ca4af201b2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 20:21:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbfMa-0000r5-4Y
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 20:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab0AaTVf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 14:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428Ab0AaTVe
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 14:21:34 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:36175 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab0AaTVe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2010 14:21:34 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:44864)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1NbfMV-0008Oi-2T
	for git@vger.kernel.org; Sun, 31 Jan 2010 14:21:35 -0500
Received: by ewy19 with SMTP id 19so1478550ewy.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 11:21:30 -0800 (PST)
Received: by 10.216.86.80 with SMTP id v58mr2262173wee.40.1264965690126; Sun, 
	31 Jan 2010 11:21:30 -0800 (PST)
In-Reply-To: <57518fd11001311116t1bde882dub1dd3ca4af201b2e@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138552>

On 31 January 2010 19:16, Jonathan del Strother <maillist@steelskies.co=
m> wrote:
> On 30 January 2010 20:25, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Please try this.
>>
>> oops, but with this, too.
>>
>>> diff --git a/submodule.c b/submodule.c
>>> index ca0527f..8bd0a30 100644
>>> --- a/submodule.c
>>> +++ b/submodule.c
>>> ...
>>> @@ -142,7 +142,9 @@ int is_submodule_modified(const char *path)
>>> =C2=A0 =C2=A0 =C2=A0 env[0] =3D strbuf_detach(&buf, NULL);
>>> =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&buf, "GIT_DIR=3D%s/.git", path);
>>> =C2=A0 =C2=A0 =C2=A0 env[1] =3D strbuf_detach(&buf, NULL);
>>> - =C2=A0 =C2=A0 env[2] =3D NULL;
>>> + =C2=A0 =C2=A0 strbuf_addf(&buf, "GIT_INDEX_FILE=3D");
>>
>> This should be:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addf(&buf, "GIT_INDEX_FILE");
>>
>>> + =C2=A0 =C2=A0 env[2] =3D strbuf_detach(&buf, NULL);
>>> + =C2=A0 =C2=A0 env[3] =3D NULL;
>>>
>>> =C2=A0 =C2=A0 =C2=A0 memset(&cp, 0, sizeof(cp));
>>> =C2=A0 =C2=A0 =C2=A0 cp.argv =3D argv;
>>
>
> Sorry, I'm not sure I follow your amendment - it looks exactly like
> the patch you originally supplied?
>
> With that original patch applied, I no longer get the 'unable to find=
'
> errors on stashing. =C2=A0However, git-status shows all my submodules=
 as
> being modified, but there appear to be no local changes :
>
> [jon@gir:Developer/AudioBooWeb]$ git status
> # On branch giterror
> # Changed but not updated:
> # =C2=A0 (use "git add <file>..." to update what will be committed)
> # =C2=A0 (use "git checkout -- <file>..." to discard changes in worki=
ng directory)
> #
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 shared/vendor/plugins/acts_as=
_list
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 shared/vendor/plugins/cucumbe=
r
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 shared/vendor/plugins/delayed=
_job
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 shared/vendor/plugins/haml
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 shared/vendor/plugins/hoptoad=
_notifier
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 shared/vendor/plugins/machini=
st
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 shared/vendor/plugins/newreli=
c_rpm
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 shared/vendor/plugins/rspec
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 shared/vendor/plugins/rspec-r=
ails
> # =C2=A0 =C2=A0 =C2=A0 modified: =C2=A0 shared/vendor/rails
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> [jon@gir:Developer/AudioBooWeb]$ git diff
> diff --git a/shared/vendor/plugins/acts_as_list
> b/shared/vendor/plugins/acts_as_list
> diff --git a/shared/vendor/plugins/cucumber b/shared/vendor/plugins/c=
ucumber
> diff --git a/shared/vendor/plugins/delayed_job
> b/shared/vendor/plugins/delayed_job
> diff --git a/shared/vendor/plugins/haml b/shared/vendor/plugins/haml
> diff --git a/shared/vendor/plugins/hoptoad_notifier
> b/shared/vendor/plugins/hoptoad_notifier
> diff --git a/shared/vendor/plugins/machinist b/shared/vendor/plugins/=
machinist
> diff --git a/shared/vendor/plugins/newrelic_rpm
> b/shared/vendor/plugins/newrelic_rpm
> diff --git a/shared/vendor/plugins/rspec b/shared/vendor/plugins/rspe=
c
> diff --git a/shared/vendor/plugins/rspec-rails
> b/shared/vendor/plugins/rspec-rails
> diff --git a/shared/vendor/rails b/shared/vendor/rails
>

=2E..  however, the latest version of master
(b0883aa6c77111e88496bd0afe073caf68ab9f99) gives me no errors, and
(correctly) doesn't show my submodules as being modified.  I still
don't quite follow exactly what was wrong, but thanks :)
