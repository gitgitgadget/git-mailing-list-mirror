From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack: Fail if cloning empty namespace
Date: Sun, 21 Jun 2015 11:43:43 -0700
Message-ID: <xmqqa8vskilc.fsf@gitster.dls.corp.google.com>
References: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
	<1434147436-21272-1-git-send-email-johannes@kyriasis.com>
	<20150612223223.GA22677@leeloo.kyriasis.com>
	<xmqqh9q87l3x.fsf@gitster.dls.corp.google.com>
	<20150620142705.GA23163@leeloo.kyriasis.com>
	<xmqqr3p6jltx.fsf@gitster.dls.corp.google.com>
	<xmqqmvzujcvb.fsf@gitster.dls.corp.google.com>
	<20150620214901.GA5520@leeloo.kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes =?utf-8?Q?L=C3=B6thberg?= <johannes@kyriasis.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 20:43:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6kDj-0003bN-4s
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 20:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbbFUSns convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Jun 2015 14:43:48 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33654 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbbFUSnq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 14:43:46 -0400
Received: by igbqq3 with SMTP id qq3so48821591igb.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 11:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=IX1veax4vCd7LyldGvl7qxjRQqmZvrs/yx1ufcQ1oW0=;
        b=iExULn0cQPr75pR4OVrGis8iSf8Z2uJuY/2q7BAzXXPpugWCJY/ezyywl06dd+hgFb
         wDKIqRKASH9Exyr0VEtJ9M+p9VQxYNvpDAUigR/dVCWWOiEBWXvOGY9cf7FtCL1XRGbD
         ZhBR8Hs11yWCdIOD9BYKvgEpXr9oRMgX3pfoMjWzeIXY6US/CqbZwozRpNfEOSM8uOkB
         ogK04fVMlPJBmt4TjOtiD0AWsUA2mRxlkPc6Ezqklwj1R5LUOt2JktnT3Ls6SjKxpyDT
         iUn3XIJBXbN+w79rAiNPGWfgOqv4G0xCTQMvI32q1YADAcleNxU5WjaKsNlV87BSdhH9
         wJzw==
X-Received: by 10.107.129.210 with SMTP id l79mr33822862ioi.32.1434912225934;
        Sun, 21 Jun 2015 11:43:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:990b:778:aa29:b388])
        by mx.google.com with ESMTPSA id ax8sm6103518igc.17.2015.06.21.11.43.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jun 2015 11:43:44 -0700 (PDT)
In-Reply-To: <20150620214901.GA5520@leeloo.kyriasis.com> ("Johannes
	=?utf-8?Q?L=C3=B6thberg=22's?= message of "Sat, 20 Jun 2015 23:49:01
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272279>

Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:

>>But if we made some change to the transfer to push-to-receive-pack
>>so that this can also create HEAD that points at something, what
>>would the user say, instead of that earlier
>>
>> $ git clone git://site.xz/r
>>
>>to access this new namespace?  Don't you have to be running another
>>instance of a server with GIT_NAMESPACE set to 'b'?  How do you
>>arrange that to automagically happen?
>>
>>Or do your users that clone/fetch do things differnetly from the
>>above, and if so what do they do?
>>
>>How is your server configured to support the access the existing
>>namespace 'a', and the new namespace 'b' that is automatically
>>created by pointing /usr/share/git/r.git/refs/namespaces/b/HEAD
>>to one ref inside that namespace?

Your answer to the above question marks are?

> If you want to hide the fact that you're using namespaces you'll
> probably have to either run another daemon or use a wrapper script,
> yes, but only if you want to hide it.

I would view it as segregating (not mixing refs and objects
reachable by them for 'a' and 'b') more than "hiding".  Either way,
your users' clone/fetch need a way to say which one of 'a' or 'b'
they want.  How are you arranging that to happen when you add a new
namespace 'b'?

I asked you if my understanding of your workflow to start populating
a new namespace 'b' matches what you actually do in reality, but you
omitted it from your quote in your response, which was this:

>> In order to add a new namespace 'b' next to 'a', you would somehow
>> need to populate /usr/share/git/r.git/refs/namespaces/b.  Presumably
>> you can prepare a source repository locally and then push everything
>> there manually, by doing something like this:
>>=20
>>  $ git push ssh://site.xz/usr/share/git/r.git refs/*:refs/namespaces=
/b/*
>>=20
>> but we agree that this does not create refs/namespaces/b/HEAD.

I'd assume that the answer is "yes, Junio got the 'push' to populate
correctly" and continue.

Populating refs/namespaces/b/ and the objects reachable by them by
pushing into that hierarchy is one step of doing so, and setting
HEAD there is not done by "git push", but is that the only thing
missing?

I do not view "git fetch --namespace=3Db" or "git clone --namespace=3Db
git://site.xz/r" as a usable way to do so (is there an option like
that in the first place?), and that is what I have been asking.

Note that I am not opposed to an idea to make it possible to point a
symbolic ref .git/$something/HEAD at a ref that is different from
what it is pointing at currently (or creating it if it does not
exist yet) from outside the server, i.e. without ssh-ing in and
running "git symbolic ref".

That $something may be "refs/namespaces/b" in your case, but it does
not have to be.  We do not have a good way to support more common
case of repointing ".git/HEAD" to say "now the primary branch of
this repository is not 'master' but it is called 'trunk'".

That is one reason why I do not want a patch to receive-pack that
randomly picks one ref among all refs pushed and point HEAD at it,
which is the following part from your patch in the other thread
(where we should be having this discussion ;-).

@@ -981,6 +983,14 @@ static const char *update(struct command *cmd, str=
uct shallow_info *si)
 		return NULL; /* good */
 	}
 	else {
+		namespace =3D get_git_namespace();
+		if (strcmp(namespace, "refs/namespaces/")) {
+			strbuf_addf(&namespaced_head_buf, "%s%s", namespace, "HEAD");
+			namespaced_head_path =3D strbuf_detach(&namespaced_head_buf, NULL);
+
+			create_symref(namespaced_head_path, namespaced_name, NULL);
+		}
+
 		struct strbuf err =3D STRBUF_INIT;
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))

This is part of update() function in receive-pack, which is called
for each and every ref that is pushed.  If you did the "initial
population push" I cited from earlier part of the discussion:

 $ git push ssh://site.xz/usr/share/git/r.git refs/*:refs/namespaces/b/=
*

the above would see updates to refs/namespaces/b/refs/heads/master,
refs/namespaces/b/refs/heads/next, refs/namespaces/b/refs/tags/v1.0,
etc., i.e. all the refs you are pushing in an unspecified order, and
the added code would run once for each and every one of them.  Where
would the final HEAD points at is not something you can control, and
once you create one, you cannot repoint to a more reasonable ref.

If we introduce a way to point any symbolic ref at a ref that is
different from what it is pointing at currently (or creating it if
it does not exist yet) from outside the server, i.e. without ssh-ing
in and running "git symbolic ref", then that would work equally well
for your use case, and also will solve longstanding "how do I change
the primary branch the server's HEAD points at?" problem.  I do not
think your patch is a good first step to introduce that solution.
