Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA16C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 22:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiI0WYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI0WYt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 18:24:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4F09877E
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:24:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CB351CF324;
        Tue, 27 Sep 2022 18:24:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GkVMM3cUe8hQ
        zHsi6ER/EnAtX3mEzkKES86ilLXC9Vw=; b=hbTxLdr+uNHL3tYnQ13qlkBgTLWX
        cmTiz00ogL9/xjZGlzHFIrIu07EJrL+6tCRz+GGgegQgRPrK0rbDGfLPYVJPZujH
        XGI0B5RLV/M/QbVjtH08Rd1fdRpRpj0D1HzsfcHYYgkkrF0t3KMZKrb0IwwErgqv
        +Ds+1ndV/IvIh6Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 581F81CF323;
        Tue, 27 Sep 2022 18:24:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C9B041CF322;
        Tue, 27 Sep 2022 18:24:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: description for non-existent branch errors
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
        <858edf12-67b1-5e2c-dd2e-3eb476530803@gmail.com>
        <xmqqleq6ovh4.fsf@gitster.g>
        <26a5cbe2-d821-e7f6-e56f-4ad90ef2cf2d@gmail.com>
Date:   Tue, 27 Sep 2022 15:24:41 -0700
In-Reply-To: <26a5cbe2-d821-e7f6-e56f-4ad90ef2cf2d@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Tue, 27 Sep 2022 01:35:13 +0200")
Message-ID: <xmqqedvw1mmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2F166E34-3EB3-11ED-92DD-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> I pointed out in the first mail of this thread, there is already a patc=
h in
> 'seen' that touches builtin/branch.c [1].  I would like to keep the pat=
ches
> separated, but I don't know how to proceed: make the change from 'seen'=
, keep
> it from 'master'... Maybe you can give me some guidance in this.

I do not see much problem in keeping them separated.  My trial merge
of the result of applying this patch on top of 'master', with the
other topic that has the "branch description for nth prior checkout"
patch does show a minor textual conflict, but the resolution does
not look too bad.

Check near the topic branch of 'seen' after I push out today's
integration result in a few hours and see if they look reasonable.

Thanks.


diff --cc builtin/branch.c
index 5ca35064f3,13d1f028da..2b3884ce61
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@@ -810,19 -807,18 +814,18 @@@ int cmd_branch(int argc, const char **a
 =20
  		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
  		if (!ref_exists(branch_ref.buf)) {
- 			strbuf_release(&branch_ref);
-=20
 -			if (!argc)
 +			if (!argc || !strcmp(head, branch_name))
- 				return error(_("No commit on branch '%s' yet."),
+ 				ret =3D error(_("No commit on branch '%s' yet."),
  					     branch_name);
  			else
- 				return error(_("No branch named '%s'."),
+ 				ret =3D error(_("No branch named '%s'."),
  					     branch_name);
- 		}
- 		strbuf_release(&branch_ref);
+ 		} else
+ 			ret =3D edit_branch_description(branch_name);
 =20
- 		if (edit_branch_description(branch_name))
- 			return 1;
+ 		strbuf_release(&branch_ref);
+ 		strbuf_release(&buf);
+ 		return -ret;
  	} else if (copy) {
  		if (!argc)
  			die(_("branch name required"));
