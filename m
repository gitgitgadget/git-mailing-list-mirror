Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917EEC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 21:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiGUVwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiGUVwD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 17:52:03 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3BC88CD7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:52:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C5F61AB8FA;
        Thu, 21 Jul 2022 17:52:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nfvm9AZ52Dn7
        sId3NjSvx1TV3qKT7E6xGYJBJKJ0XDU=; b=hjm1VROCZy3/7IaQMm+7arOy8EQd
        4XhCVLj9eJvryArsxbbtJJzB2V8sUHbnSuIKkyNFD+2K+H9bEDE3TVlnbi59on3E
        lCuJavJE6JIvxCoVKkYYLvGvIkGMOEvFa54vEQXs8HinRzW0Y7OXMRBFMcCFPB5v
        HYM/RLs2ZMyY5/I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85F1C1AB8F9;
        Thu, 21 Jul 2022 17:52:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2611F1AB8F7;
        Thu, 21 Jul 2022 17:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v3 26/26] submodule--helper: fix a
 configure_added_submodule() leak
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
        <patch-v3-26.26-581ce0872c0-20220721T191249Z-avarab@gmail.com>
Date:   Thu, 21 Jul 2022 14:51:56 -0700
In-Reply-To: <patch-v3-26.26-581ce0872c0-20220721T191249Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Jul
 2022 21:13:22
        +0200")
Message-ID: <xmqqedyedthf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57F69AA8-093F-11ED-855C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  static void configure_added_submodule(struct add_data *add_data)
>  {
>  	char *key;
> -	char *val =3D NULL;
> +	const char *val;
>  	struct child_process add_submod =3D CHILD_PROCESS_INIT;
>  	struct child_process add_gitmodules =3D CHILD_PROCESS_INIT;
> =20
> @@ -3306,7 +3306,7 @@ static void configure_added_submodule(struct add_=
data *add_data)
>  	 * is_submodule_active(), since that function needs to find
>  	 * out the value of "submodule.active" again anyway.
>  	 */
> -	if (!git_config_get_string("submodule.active", &val)) {
> +	if (!git_config_get_string_tmp("submodule.active", &val)) {

Obviously correct ;-)
