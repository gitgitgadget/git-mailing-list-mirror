From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: v1.7.0-rc0 shows lots of "unable to find <sha1>" on git-stash
Date: Sun, 31 Jan 2010 19:16:53 +0000
Message-ID: <57518fd11001311116t1bde882dub1dd3ca4af201b2e@mail.gmail.com>
References: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com> 
	<7vzl3wiz59.fsf@alter.siamese.dyndns.org> <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com> 
	<4B642696.2070501@web.de> <57518fd11001300523xf7d931by254581c8494171af@mail.gmail.com> 
	<4B643DEF.8010809@web.de> <57518fd11001300836v7f21a8a9qc09953d9091a4513@mail.gmail.com> 
	<7v8wbfnyz9.fsf@alter.siamese.dyndns.org> <7vvdejmjaj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 20:17:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbfIc-00077R-J9
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 20:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab0AaTRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 14:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216Ab0AaTRV
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 14:17:21 -0500
Received: from juliet.asmallorange.com ([207.210.105.70]:35921 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0AaTRU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2010 14:17:20 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:59251)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1NbfIM-0008DE-In
	for git@vger.kernel.org; Sun, 31 Jan 2010 14:17:18 -0500
Received: by ewy19 with SMTP id 19so1474554ewy.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 11:17:13 -0800 (PST)
Received: by 10.216.88.78 with SMTP id z56mr2251006wee.37.1264965433096; Sun, 
	31 Jan 2010 11:17:13 -0800 (PST)
In-Reply-To: <7vvdejmjaj.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138548>

On 30 January 2010 20:25, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Please try this.
>
> oops, but with this, too.
>
>> diff --git a/submodule.c b/submodule.c
>> index ca0527f..8bd0a30 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> ...
>> @@ -142,7 +142,9 @@ int is_submodule_modified(const char *path)
>> =C2=A0 =C2=A0 =C2=A0 env[0] =3D strbuf_detach(&buf, NULL);
>> =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&buf, "GIT_DIR=3D%s/.git", path);
>> =C2=A0 =C2=A0 =C2=A0 env[1] =3D strbuf_detach(&buf, NULL);
>> - =C2=A0 =C2=A0 env[2] =3D NULL;
>> + =C2=A0 =C2=A0 strbuf_addf(&buf, "GIT_INDEX_FILE=3D");
>
> This should be:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addf(&buf, "GIT_INDEX_FILE");
>
>> + =C2=A0 =C2=A0 env[2] =3D strbuf_detach(&buf, NULL);
>> + =C2=A0 =C2=A0 env[3] =3D NULL;
>>
>> =C2=A0 =C2=A0 =C2=A0 memset(&cp, 0, sizeof(cp));
>> =C2=A0 =C2=A0 =C2=A0 cp.argv =3D argv;
>

Sorry, I'm not sure I follow your amendment - it looks exactly like
the patch you originally supplied?

With that original patch applied, I no longer get the 'unable to find'
errors on stashing.  However, git-status shows all my submodules as
being modified, but there appear to be no local changes :

[jon@gir:Developer/AudioBooWeb]$ git status
# On branch giterror
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#	modified:   shared/vendor/plugins/acts_as_list
#	modified:   shared/vendor/plugins/cucumber
#	modified:   shared/vendor/plugins/delayed_job
#	modified:   shared/vendor/plugins/haml
#	modified:   shared/vendor/plugins/hoptoad_notifier
#	modified:   shared/vendor/plugins/machinist
#	modified:   shared/vendor/plugins/newrelic_rpm
#	modified:   shared/vendor/plugins/rspec
#	modified:   shared/vendor/plugins/rspec-rails
#	modified:   shared/vendor/rails
#
no changes added to commit (use "git add" and/or "git commit -a")

[jon@gir:Developer/AudioBooWeb]$ git diff
diff --git a/shared/vendor/plugins/acts_as_list
b/shared/vendor/plugins/acts_as_list
diff --git a/shared/vendor/plugins/cucumber b/shared/vendor/plugins/cuc=
umber
diff --git a/shared/vendor/plugins/delayed_job
b/shared/vendor/plugins/delayed_job
diff --git a/shared/vendor/plugins/haml b/shared/vendor/plugins/haml
diff --git a/shared/vendor/plugins/hoptoad_notifier
b/shared/vendor/plugins/hoptoad_notifier
diff --git a/shared/vendor/plugins/machinist b/shared/vendor/plugins/ma=
chinist
diff --git a/shared/vendor/plugins/newrelic_rpm
b/shared/vendor/plugins/newrelic_rpm
diff --git a/shared/vendor/plugins/rspec b/shared/vendor/plugins/rspec
diff --git a/shared/vendor/plugins/rspec-rails
b/shared/vendor/plugins/rspec-rails
diff --git a/shared/vendor/rails b/shared/vendor/rails
