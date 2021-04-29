Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32694C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 14:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE015613E8
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 14:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbhD2O0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 10:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhD2O0l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 10:26:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730A8C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 07:25:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so100126125ejc.10
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schedmd.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=kuewcpEvZ44AI1D/+VBVjM3yTbsnKt5PZjtRPMz7jF8=;
        b=LnG3eq1/oM6w1hZ98o+/Vse/WjDMVcUevd2JJjhm6+nTzT4jaNwy9ROmlpbqKg48qZ
         zol96za7b57VLktZvb9va8Qb6l3S7A/AZY9A4eo777uEXIetsNyttFF9YqDBqWBIQiMM
         PKKz4OwUz2pEWir0qqiU+9bahkzylPCMvb/t6Lu1ApawaPYOocKrjuBTvjgRhwbDem7b
         9Qvasy6lm3jfAv5Bd0x6V8zRKfm/1FJXSz4LFenuUe5LcS0nEak/PcQjhez92gO+zijS
         PulT7ZrbpQNds5C/x5oHmNo8Kd7b3CoKa3vb1Ar9Aq3VFy9WCSPePB+LQN4O1GO/4A9F
         +Jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kuewcpEvZ44AI1D/+VBVjM3yTbsnKt5PZjtRPMz7jF8=;
        b=f3sSWQSYjTE4jvfRj5qofKuB2oAgtwASPIUJcwxCrHVt01PgdUdSwK7tWL1ZWrx1hA
         9qluN4MwijeE+Dq5Z35ozvtBqRzZNLIr5CFAgHrUwBb8Fm3+6ggom7VPrP13T50YNS1L
         BlzEtXGAyZAlSmHiZYXYEXqkIU0U5PfMFYGrPWgvYr71HvGK7D1KZWMa7jGRxI4Y5h2r
         etU9yDovsHARl4SjrcRVwOom8lDXpVUyFfutkzrN6GqPwmtqzmKsebM8OeyMcYTnqhJR
         XYcq8EfJIc9xFdVA5B0ONQgStd6QtzG2Ke75tjiqM1exwbz1R7hkFuU0nTGKJLq0WnE4
         bA7w==
X-Gm-Message-State: AOAM531sX2BAg4b0mvrIj80mkPj7grNZxYt4A4cRPGZN984ua2hz58sI
        ASlH05MpStLaIY27aVRLQ/z994vZV3E6olY0CHW7VXB+Z4ErVA==
X-Google-Smtp-Source: ABdhPJxmAo4FrwrOUi4G8uvPraAqc345ezWFhszmrhPRvBT8vadUBOr4O2J0MrOxNrPnnRPn9LwsYPMBYZ++slNbvOU=
X-Received: by 2002:a17:906:1e0b:: with SMTP id g11mr66826ejj.291.1619706352981;
 Thu, 29 Apr 2021 07:25:52 -0700 (PDT)
MIME-Version: 1.0
From:   Alejandro Sanchez <alex@schedmd.com>
Date:   Thu, 29 Apr 2021 16:25:42 +0200
Message-ID: <CAF-Z3RqEz9mnnosew+TfNkV2ysaTkGj_ZXpD-4NWO7th9v_-CA@mail.gmail.com>
Subject: git am / patch utility not applying a .patch to the correct function
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cfcbf405c11d4598"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000cfcbf405c11d4598
Content-Type: text/plain; charset="UTF-8"

Hi,

In the SchedMD/Slurm project there's a source file with two functions
that have a very similar implementation with some slight variations,
namely _eval_nodes_dfly() and _eval_nodes_topo():

https://github.com/SchedMD/slurm/blob/slurm-20.11/src/plugins/select/cons_tres/job_test.c#L1458

https://github.com/SchedMD/slurm/blob/slurm-20.11/src/plugins/select/cons_tres/job_test.c#L2099

Before this Slurm commit:

https://github.com/SchedMD/slurm/commit/63e94c2ccbb62aea84cfb0b808761de2bb64e74c

When I attempted to git am a patch clearly targeted for
_eval_nodes_dfly(), the result shown by git show resulted in the
modified code in _eval_nodes_topo() instead. A colleague also reported
this is also happening with the 'patch' utility without git, we're not
sure if they both share any common logic or library behind the scenes.

I've attached a sequence of commands showing the contents of the patch
and the result after applying.

alex@polaris:~/t$ lsb_release -a
No LSB modules are available.
Distributor ID: Debian
Description: Debian GNU/Linux 10 (buster)
Release: 10
Codename: buster
alex@polaris:~/t$ git --version
git version 2.29.2
alex@polaris:~/t$

--000000000000cfcbf405c11d4598
Content-Type: text/plain; charset="US-ASCII"; name="git_problem_sequence.txt"
Content-Disposition: attachment; filename="git_problem_sequence.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_ko2zby9p0>
X-Attachment-Id: f_ko2zby9p0

YWxleEBwb2xhcmlzOn4vc2x1cm0vc291cmNlJCBjYXQgfi9Eb3dubG9hZHMvYnVnMTE0MDFfMjAx
MV9jb3Zlcml0eV92NS5wYXRjaApGcm9tIGNkZTJjNjA0ODJlNzA0Y2JiOWY1Njc3ZWEyODM5MDJj
MjZjMzc2NWYgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IENhcmxvcyBUcmlwaWFuYSBN
b250ZXMgPHRyaXBpYW5hQHNjaGVkbWQuY29tPgpEYXRlOiBUaHUsIDI5IEFwciAyMDIxIDE0OjMz
OjE4ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gc2VsZWN0L2NvbnNfdHJlcyB3aXRoIGRyYWdvbmZs
eTogRml4IGNvdmVyaXR5IE5VTEwgZGVyZWZlcmVuY2UKQ29udGludWF0aW9uIG9mIDg0NzVhZTlk
NzdlMzA1ODVmZmQyNzMzZTk3ZGZjMmI1YTA3YzdjYWIKQ292ZXJpdHkgQ0lEIDIyMTUxMQpCdWcg
MTE0MDEKLS0tCiBzcmMvcGx1Z2lucy9zZWxlY3QvY29uc190cmVzL2pvYl90ZXN0LmMgfCAzICsr
LQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQpkaWZmIC0t
Z2l0IGEvc3JjL3BsdWdpbnMvc2VsZWN0L2NvbnNfdHJlcy9qb2JfdGVzdC5jIGIvc3JjL3BsdWdp
bnMvc2VsZWN0L2NvbnNfdHJlcy9qb2JfdGVzdC5jCmluZGV4IDJkMjUzNDU5NDUuLmZmMTI1ZmFm
YTMgMTAwNjQ0Ci0tLSBhL3NyYy9wbHVnaW5zL3NlbGVjdC9jb25zX3RyZXMvam9iX3Rlc3QuYwor
KysgYi9zcmMvcGx1Z2lucy9zZWxlY3QvY29uc190cmVzL2pvYl90ZXN0LmMKQEAgLTIwNDUsNyAr
MjA0NSw4IEBAIHN0YXRpYyBpbnQgX2V2YWxfbm9kZXNfZGZseShqb2JfcmVjb3JkX3QgKmpvYl9w
dHIsCiAJcmMgPSBTTFVSTV9FUlJPUjsKIGZpbmk6Ci0JaWYgKGpvYl9wdHItPnJlcV9zd2l0Y2gg
PiAwICYmIHJjID09IFNMVVJNX1NVQ0NFU1MpIHsKKwlpZiAoam9iX3B0ci0+cmVxX3N3aXRjaCA+
IDAgJiYgc3dpdGNoX25vZGVfYml0bWFwICYmCisJICAgIHJjID09IFNMVVJNX1NVQ0NFU1MpIHsK
IAkJaW50IGxlYWZfc3dpdGNoX2NvdW50ID0gMDsKIAkJLyogQ291bnQgdXAgbGVhZiBzd2l0Y2hl
cy4gKi8KLS0gCjIuMjUuMQphbGV4QHBvbGFyaXM6fi9zbHVybS9zb3VyY2UkIGdpdCBhbSAtMyAt
aSB+L0Rvd25sb2Fkcy9idWcxMTQwMV8yMDExX2NvdmVyaXR5X3Y1LnBhdGNoCkNvbW1pdCBCb2R5
IGlzOgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpzZWxlY3QvY29uc190cmVzIHdpdGggZHJh
Z29uZmx5OiBGaXggY292ZXJpdHkgTlVMTCBkZXJlZmVyZW5jZQpDb250aW51YXRpb24gb2YgODQ3
NWFlOWQ3N2UzMDU4NWZmZDI3MzNlOTdkZmMyYjVhMDdjN2NhYgpDb3Zlcml0eSBDSUQgMjIxNTEx
CkJ1ZyAxMTQwMQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBcHBseT8gW3ldZXMvW25dby9b
ZV1kaXQvW3ZdaWV3IHBhdGNoL1thXWNjZXB0IGFsbDogeQpBcHBseWluZzogc2VsZWN0L2NvbnNf
dHJlcyB3aXRoIGRyYWdvbmZseTogRml4IGNvdmVyaXR5IE5VTEwgZGVyZWZlcmVuY2UKYWxleEBw
b2xhcmlzOn4vc2x1cm0vc291cmNlJCBnaXQgc2hvdyBIRUFECmNvbW1pdCBmNTJhM2IwOGNkODk1
ODIwYzM3NjU3NzUxOWM1NDEzZGU3MjU5YmI0IChIRUFEIC0+IHNsdXJtLTIwLjExKQpBdXRob3I6
ICAgICBDYXJsb3MgVHJpcGlhbmEgTW9udGVzIDx0cmlwaWFuYUBzY2hlZG1kLmNvbT4KQXV0aG9y
RGF0ZTogVGh1IEFwciAyOSAxNDozMzoxOCAyMDIxICswMjAwCkNvbW1pdDogICAgIEFsZWphbmRy
byBTYW5jaGV6IDxhbGV4QHNjaGVkbWQuY29tPgpDb21taXREYXRlOiBUaHUgQXByIDI5IDE1OjM1
OjM2IDIwMjEgKzAyMDAKICAgIHNlbGVjdC9jb25zX3RyZXMgd2l0aCBkcmFnb25mbHk6IEZpeCBj
b3Zlcml0eSBOVUxMIGRlcmVmZXJlbmNlCiAgICBDb250aW51YXRpb24gb2YgODQ3NWFlOWQ3N2Uz
MDU4NWZmZDI3MzNlOTdkZmMyYjVhMDdjN2NhYgogICAgQ292ZXJpdHkgQ0lEIDIyMTUxMQogICAg
QnVnIDExNDAxCmRpZmYgLS1naXQgYS9zcmMvcGx1Z2lucy9zZWxlY3QvY29uc190cmVzL2pvYl90
ZXN0LmMgYi9zcmMvcGx1Z2lucy9zZWxlY3QvY29uc190cmVzL2pvYl90ZXN0LmMKaW5kZXggYWNi
MmFlMzBkZi4uYmMzYTgxZjk2NSAxMDA2NDQKLS0tIGEvc3JjL3BsdWdpbnMvc2VsZWN0L2NvbnNf
dHJlcy9qb2JfdGVzdC5jCisrKyBiL3NyYy9wbHVnaW5zL3NlbGVjdC9jb25zX3RyZXMvam9iX3Rl
c3QuYwpAQCAtMjYyNiw3ICsyNjI2LDggQEAgc3RhdGljIGludCBfZXZhbF9ub2Rlc190b3BvKGpv
Yl9yZWNvcmRfdCAqam9iX3B0ciwKICAgICAgICByYyA9IFNMVVJNX0VSUk9SOwogZmluaToKLSAg
ICAgICBpZiAoam9iX3B0ci0+cmVxX3N3aXRjaCA+IDAgJiYgcmMgPT0gU0xVUk1fU1VDQ0VTUykg
eworICAgICAgIGlmIChqb2JfcHRyLT5yZXFfc3dpdGNoID4gMCAmJiBzd2l0Y2hfbm9kZV9iaXRt
YXAgJiYKKyAgICAgICAgICAgcmMgPT0gU0xVUk1fU1VDQ0VTUykgewogICAgICAgICAgICAgICAg
aW50IGxlYWZfc3dpdGNoX2NvdW50ID0gMDsKICAgICAgICAgICAgICAgIC8qIENvdW50IHVwIGxl
YWYgc3dpdGNoZXMuICovCmFsZXhAcG9sYXJpczp+L3NsdXJtL3NvdXJjZSQK
--000000000000cfcbf405c11d4598--
