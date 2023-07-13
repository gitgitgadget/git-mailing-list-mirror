Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EB6C001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 20:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjGMUW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGMUW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 16:22:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B7F2121
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 13:22:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-316eabffaa6so751206f8f.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689279774; x=1691871774;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqlig5sgwpDzGLPL6dmcOWXL6bMigR7TqsWZeBpzciw=;
        b=crCSk6/+IglUel6+tY+Zjd+9z/E4Y7rM5cYKrRxzHjxDpO/dPAnlJ3AHeN/AtKOoXN
         Nzh2vw7ElSbA0FlxtsaUr6/X7FLM/FfHhC3PcNR1lG7gjSKqvSOfVJVjKvIbQ0B5c400
         jtjMcil6908gui6DkcnjB6+qCdwqnXXl6GhjIm6R3xLOrLOi8LxxguqXr4hWiXLeYp8V
         jFfzdUvcUpwES5XGsV1c6W04wO5J23L+RibWCr18fFWBSSdQaFcEAj1Wx7oqasxGUR7d
         WfGZ3yglCjOcYflCRqPfFFTlE0WggmLrwla9krHjSqT/vKEm401D1VypXbX2UAjvWU15
         PpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279774; x=1691871774;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqlig5sgwpDzGLPL6dmcOWXL6bMigR7TqsWZeBpzciw=;
        b=cThtnI/VcKSoITmiShGkiocrWZygIjajEnVnP+7deomR9bAUB8gAKG6ySbvYF7jQCq
         /rcnTp3a4jiA7vERxJaNjQ2hZWRRtyMjwUmNdz2GcrKWIO4pFpCiyDqwWWGPhBupsU5q
         pNkacGT12HvPMgGA33BUwQsblA79E0P6vIR79ojSvvTJXDX9NL4I2c52bMIUTCPwicxk
         uNNsBaLXtICfh/D33VRIuru7zEFu3SFh9/O7uxRLJ/S+o3hmHFPs0DU2aFtq3qL1PeXC
         2J/2TFQZ3MYA6IE/RWOXjcZ2ek7wmnA7sflAJVDUYg8n1nEnYN4YBmcoxBOJirrSGOqj
         e6kw==
X-Gm-Message-State: ABy/qLZT4HWpvDqVHWbQhm4h67XfkatmzKszyMtS1jijm4adksTNfQyM
        lpjtmw9Hl74HOObrnCCDQKGUpSRZ8nLZTMsMOUs=
X-Google-Smtp-Source: APBJJlE0AT7dAQmsVxL4eXBlMKX/xRb7t9sTyCMPfTis029varW2Q1zMPr/7EHONocDyrL31yjsWrTZ9Fvbq2ywJEuo=
X-Received: by 2002:a5d:514b:0:b0:313:e9d7:108f with SMTP id
 u11-20020a5d514b000000b00313e9d7108fmr2223820wrt.33.1689279774422; Thu, 13
 Jul 2023 13:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230707151839.504494-1-cheskaqiqi@gmail.com> <20230711133035.16916-1-cheskaqiqi@gmail.com>
 <20230711133035.16916-2-cheskaqiqi@gmail.com> <xmqqjzv6w3o2.fsf@gitster.g> <xmqqfs5uw178.fsf@gitster.g>
In-Reply-To: <xmqqfs5uw178.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Thu, 13 Jul 2023 16:22:42 -0400
Message-ID: <CAMO4yUEh+HMZi8wC1aB=6oLCJkn3CNbw0reVAA-vULfVgF+=NA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] attr.c: read attributes in a sparse directory
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2023 at 6:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> -    if (!path_in_cone_mode_sparse_checkout(path, istate))
> >> -            return NULL;
> >> +    pos =3D index_name_pos_sparse(istate, path, strlen(path));
> >> +    pos =3D - pos - 2;
> >>
> >> -    buf =3D read_blob_data_from_index(istate, path, &size);
> >> -    if (!buf)
> >> -            return NULL;
> >> -    if (size >=3D ATTR_MAX_FILE_SIZE) {
> >> -            warning(_("ignoring overly large gitattributes blob '%s'"=
), path);
> >> -            return NULL;
> >> -    }
> >> +    if (!path_in_cone_mode_sparse_checkout(path, istate) && 0 <=3D po=
s) {
> >> +            if (!S_ISSPARSEDIR(istate->cache[pos]->ce_mode))
> >> +                    return NULL;
>
> Another thing I forgot to ask.  When we are asked to read
> ".gitattributes" at the top level, does this code work correctly?
> As ".gitattributes" is at the root level, it won't be hidden inside
> a sparsified directory in the index, and we do not have to search
> for its parent.  I just wanted to see if the relative_path computation
> and other things we see below will safely be skipped in such a case.

Yeah, this code works correctly. I added those tests in t1092 and they
passed successfully.

test_expect_success 'check-attr with pathspec inside sparse definition' '
init_repos &&

    echo "a -crlf myAttr" >>.gitattributes &&
    run_on_all cp ../.gitattributes . &&

    test_all_match git check-attr -a -- deep/a &&

    test_all_match git add .gitattributes &&
    test_all_match git check-attr -a --cached -- deep/a
'
test_expect_success 'check-attr with pathspec inside sparse definition' '
init_repos &&

    echo "a -crlf myAttr" >>.gitattributes &&
    run_on_all cp ../.gitattributes . &&

    test_all_match git check-attr -a -- folder1/a &&

    test_all_match git add .gitattributes &&
    test_all_match git check-attr -a --cached -- folder1/a
'

Do I need to modify t1092 to include cases like this?
