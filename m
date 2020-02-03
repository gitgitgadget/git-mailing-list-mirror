Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78284C35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 15:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412BA2192A
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 15:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRylg68j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgBCPW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:22:59 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:44601 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgBCPW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 10:22:59 -0500
Received: by mail-io1-f42.google.com with SMTP id z16so12396337iod.11
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 07:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OBhBo2pZU6gSL7kGNrOAVijDpwxxYUCMWqqzfc2pip4=;
        b=aRylg68jLm8wwgwfS9A2wSNzLw2jUSak8qlxfD6XoM8yntvQzogYMsaNjg9ypLef3P
         eqj1UkLItuD5S6EIHcTJfPaaHkcKMAG02QNOfvHLZeY7wCJToMAFAbHd/Aw0p04/3cNC
         4V89QswJkCeKjbQ8Rr30dTo591ynETQpjwNapI5v8b75TvNYaB+KrzmmhZ2NZL6yMnO2
         CJ9en2Y1w3l+rTAsBjySoXvo5gJbFJkyoCUVkGosxyzS8Sc1+yD+GRonN001BLxpPRl4
         PfAkw8E4xl/8Giz08DrfbkVS7M2+RBGf7kVg0a5O722NcXz3VBbYbpDlHmsnyOKP5uwr
         xRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OBhBo2pZU6gSL7kGNrOAVijDpwxxYUCMWqqzfc2pip4=;
        b=c5HvUQ2DGuhvLtEtE4UUKBF39b9kQSG8u1sLWsBC/QHgvgEDSJ+hYhLd2+vdE0NS1q
         dLqbJFNmn/GS1btT/+Ka5q03HJU/za2g2YTJvr0KGgVkQwRdINjRrJUMnCnff+dIw6gC
         bQBV7DALLF2aaD+UYusn3C8arEtrE3vhQFuNGqXx8BdrJK66EfBp3EEwRuj1YH1/6J0p
         GuSKBhNXg8iGaUytPU+q1FhWF+Fdu2Hs+p9l8rszz5u35Tx1sneWBE0OcxUEmH0LiCe0
         MibMf+cG5Joo7KT7tWCivqYvD7ibRUnivFvKaPnu+pFjXUGDBrktwxsSVVkOi19L4emM
         CKgg==
X-Gm-Message-State: APjAAAU9Wr3OCEzsRGQLOkAszcJ609B0MMo/ZZM6gqDONKwq3xOenw7p
        IyvCUXxs+1e+FTQrDdFOBs8VBhLukLQj/mGQ7F10T8Cp
X-Google-Smtp-Source: APXvYqzm0SSiezgsiL6vsYrkjCRC6Jxyp2JriIBWccs5UUXssreIqODhOqISeA180MREmw0wtRA2d/jAk3LSh/oi7X8=
X-Received: by 2002:a02:c951:: with SMTP id u17mr20422242jao.27.1580743377793;
 Mon, 03 Feb 2020 07:22:57 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 3 Feb 2020 10:22:46 -0500
Message-ID: <CAH8yC8kaWXbN+RYMJnM9em7KKW54+N07JtyS1MZk0qppD=m2BA@mail.gmail.com>
Subject: Fix inet_ntop and inet_pton on Solaris
To:     Git List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000848795059dad7f75"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000848795059dad7f75
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

inet_ntop and inet_pton were not being detected properly on modern on
Solaris. This patch revisits the the socket gear configuration on
SunOS and brings it up to date for Solaris 11.

According to configure.ac, the three or four functions of interest
include hstrerror, inet_ntop and inet_pton. The libraries of interest
are -lresolv -lsocket -lnsl. The configure tests now look for
inet_ntop and inet_pton in -lsocket -lnsl per the man page. If not
found, the configure tests fall back to existing behavior by searching
in -lresolv. And if not found in -lresolv, then NO_INET_NTOP and
NO_INET_PTON are set.

Here's the configure fly-by:

checking for socket... no
checking for library containing socket... no
checking for inet_ntop... no
checking for library containing inet_ntop... -lnsl
checking for inet_pton... yes
checking for hstrerror... no
checking for library containing hstrerror... -lresolv

And config.status:

$ /usr/gnu/bin/grep -E 'RESOLV|SOCKET|NSL' config.status
NEEDS_RESOLV=YesPlease
NEEDS_SOCKET=YesPlease
NEEDS_NSL=YesPlease

Jeff

--000000000000848795059dad7f75
Content-Type: text/x-patch; charset="US-ASCII"; name="solaris.diff"
Content-Disposition: attachment; filename="solaris.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k66lms9p0>
X-Attachment-Id: f_k66lms9p0

ZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggMDlmOThiNzc3Yy4uNzE2NmIx
OWFiNCAxMDA2NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTE0NjEsMTUgKzE0
NjEsMTUgQEAgaWZuZGVmIExJQkNfQ09OVEFJTlNfTElCSU5UTAogCUVYVExJQlMgKz0gLWxpbnRs
CiBlbmRpZgogZW5kaWYKK2lmZGVmIE5FRURTX1JFU09MVgorCUVYVExJQlMgKz0gLWxyZXNvbHYK
K2VuZGlmCiBpZmRlZiBORUVEU19TT0NLRVQKIAlFWFRMSUJTICs9IC1sc29ja2V0CiBlbmRpZgog
aWZkZWYgTkVFRFNfTlNMCiAJRVhUTElCUyArPSAtbG5zbAogZW5kaWYKLWlmZGVmIE5FRURTX1JF
U09MVgotCUVYVExJQlMgKz0gLWxyZXNvbHYKLWVuZGlmCiBpZmRlZiBOT19EX1RZUEVfSU5fRElS
RU5UCiAJQkFTSUNfQ0ZMQUdTICs9IC1ETk9fRF9UWVBFX0lOX0RJUkVOVAogZW5kaWYKZGlmZiAt
LWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2NvbmZpZ3VyZS5hYwppbmRleCA2NmFlZGI5Mjg4Li5iODNh
MGU5NzBkIDEwMDY0NAotLS0gYS9jb25maWd1cmUuYWMKKysrIGIvY29uZmlndXJlLmFjCkBAIC03
MTEsNDAgKzcxMSw1OCBAQCBHSVRfVU5TVEFTSF9GTEFHUygkWkxJQl9QQVRIKQogCiBHSVRfQ09O
Rl9TVUJTVChbTk9fREVGTEFURV9CT1VORF0pCiAKKyMKKyMgVGhlIG5leHQgZmV3IHRlc3RzIHdp
bGwgZGVmaW5lIE5FRURTX1JFU09MViwgTkVFRFNfU09DS0VUIG9yCisjIE5FRURTX05TTCBpZiBs
aW5raW5nIHdpdGggbGlicmVzb2x2LCBsaWJzb2NrZXQgYW5kIGxpYm5zbAorIyBwcm92aWRlcyBz
b21lIG9mIHRoZSBmdW5jdGlvbnMgd2Ugd291bGQgbm9ybWFsbHkgZ2V0IGZyb20gbGliYy4KK05F
RURTX1JFU09MVj0KK05FRURTX1NPQ0tFVD0KK05FRURTX05TTD0KKwogIwogIyBEZWZpbmUgTkVF
RFNfU09DS0VUIGlmIGxpbmtpbmcgd2l0aCBsaWJjIGlzIG5vdCBlbm91Z2ggKFN1bk9TLAogIyBQ
YXRyaWNrIE1hdXJpdHopLgotQUNfQ0hFQ0tfTElCKFtjXSwgW3NvY2tldF0sCi1bTkVFRFNfU09D
S0VUPV0sCi1bTkVFRFNfU09DS0VUPVllc1BsZWFzZV0pCi1HSVRfQ09ORl9TVUJTVChbTkVFRFNf
U09DS0VUXSkKLXRlc3QgLW4gIiRORUVEU19TT0NLRVQiICYmIExJQlM9IiRMSUJTIC1sc29ja2V0
IgorQUNfQ0hFQ0tfRlVOQyhbc29ja2V0XSwKKyAgICBbXSwKKyAgICBbQUNfU0VBUkNIX0xJQlMo
W3NvY2tldF0sIFtjXSwKKyAgICAgICBbTkVFRFNfU09DS0VUPV0sCisgICAgICAgW05FRURTX1NP
Q0tFVD1ZZXNQbGVhc2VdKQorXSkKIAogIwotIyBUaGUgbmV4dCBmZXcgdGVzdHMgd2lsbCBkZWZp
bmUgTkVFRFNfUkVTT0xWIGlmIGxpbmtpbmcgd2l0aAotIyBsaWJyZXNvbHYgcHJvdmlkZXMgc29t
ZSBvZiB0aGUgZnVuY3Rpb25zIHdlIHdvdWxkIG5vcm1hbGx5IGdldAotIyBmcm9tIGxpYmMuCi1O
RUVEU19SRVNPTFY9Ci0jCi0jIERlZmluZSBOT19JTkVUX05UT1AgaWYgbGlua2luZyB3aXRoIC1s
cmVzb2x2IGlzIG5vdCBlbm91Z2guCi0jIFNvbGFyaXMgMi43IGluIHBhcnRpY3VsYXIgaG9zIGlu
ZXRfbnRvcCBpbiAtbHJlc29sdi4KKyMgRGVmaW5lIE5PX0lORVRfTlRPUCBpZiBsaW5raW5nIHdp
dGggLWxyZXNvbHYsIC1sc29ja2V0IGFuZCAtbG5zbAorIyBpcyBub3QgZW5vdWdoLiBTb2xhcmlz
IDExIHByb3ZpZGVzIGluZXRfbnRvcCBpbiAtbHNvY2tldCAtbG5zbC4KKyMgU29sYXJpcyAyLjcg
cHJvdmlkZXMgaW5ldF9udG9wIGluIC1scmVzb2x2LgogTk9fSU5FVF9OVE9QPQogQUNfQ0hFQ0tf
RlVOQyhbaW5ldF9udG9wXSwKICAgICBbXSwKLSAgICBbQUNfQ0hFQ0tfTElCKFtyZXNvbHZdLCBb
aW5ldF9udG9wXSwKLQlbTkVFRFNfUkVTT0xWPVllc1BsZWFzZV0sCi0JW05PX0lORVRfTlRPUD1Z
ZXNQbGVhc2VdKQorICAgIFtBQ19TRUFSQ0hfTElCUyhbaW5ldF9udG9wXSwgW3NvY2tldCBuc2xd
LAorICAgICAgIFtORUVEU19TT0NLRVQ9WWVzUGxlYXNlOyBORUVEU19OU0w9WWVzUGxlYXNlXSwK
KyAgICAgICBbQUNfQ0hFQ0tfRlVOQyhbaW5ldF9udG9wXSwKKyAgICAgICAgICBbXSwKKyAgICAg
ICAgICBbQUNfU0VBUkNIX0xJQlMoW2luZXRfbnRvcF0sIFtyZXNvbHZdLAorICAgICAgICAgIFtO
RUVEU19SRVNPTFY9WWVzUGxlYXNlXSwKKyAgICAgICAgICBbTk9fSU5FVF9QVE9OPVllc1BsZWFz
ZV0pCisgICAgICAgXSkKKyAgICBdKQogXSkKIEdJVF9DT05GX1NVQlNUKFtOT19JTkVUX05UT1Bd
KQogIwotIyBEZWZpbmUgTk9fSU5FVF9QVE9OIGlmIGxpbmtpbmcgd2l0aCAtbHJlc29sdiBpcyBu
b3QgZW5vdWdoLgotIyBTb2xhcmlzIDIuNyBpbiBwYXJ0aWN1bGFyIGhvcyBpbmV0X3B0b24gaW4g
LWxyZXNvbHYuCisjIERlZmluZSBOT19JTkVUX1BUT04gaWYgbGlua2luZyB3aXRoIC1scmVzb2x2
LCAtbHNvY2tldCBhbmQgLWxuc2wKKyMgaXMgbm90IGVub3VnaC4gU29sYXJpcyAxMSBwcm92aWRl
cyBpbmV0X3B0b24gaW4gLWxzb2NrZXQgLWxuc2wuCisjIFNvbGFyaXMgMi43IHByb3ZpZGVzIGlu
ZXRfcHRvbiBpbiAtbHJlc29sdi4KIE5PX0lORVRfUFRPTj0KIEFDX0NIRUNLX0ZVTkMoW2luZXRf
cHRvbl0sCiAgICAgW10sCi0gICAgW0FDX0NIRUNLX0xJQihbcmVzb2x2XSwgW2luZXRfcHRvbl0s
Ci0JW05FRURTX1JFU09MVj1ZZXNQbGVhc2VdLAotCVtOT19JTkVUX1BUT049WWVzUGxlYXNlXSkK
KyAgICBbQUNfU0VBUkNIX0xJQlMoW2luZXRfcHRvbl0sIFtzb2NrZXQgbnNsXSwKKyAgICAgICBb
TkVFRFNfU09DS0VUPVllc1BsZWFzZTsgTkVFRFNfTlNMPVllc1BsZWFzZV0sCisgICAgICAgW0FD
X0NIRUNLX0ZVTkMoW2luZXRfcHRvbl0sCisgICAgICAgICAgW10sCisgICAgICAgICAgW0FDX1NF
QVJDSF9MSUJTKFtpbmV0X3B0b25dLCBbcmVzb2x2XSwKKyAgICAgICAgICBbTkVFRFNfUkVTT0xW
PVllc1BsZWFzZV0sCisgICAgICAgICAgW05PX0lORVRfUFRPTj1ZZXNQbGVhc2VdKQorICAgICAg
IF0pCisgICAgXSkKIF0pCiBHSVRfQ09ORl9TVUJTVChbTk9fSU5FVF9QVE9OXSkKICMKQEAgLTc1
MywxOSArNzcxLDI2IEBAIEdJVF9DT05GX1NVQlNUKFtOT19JTkVUX1BUT05dKQogTk9fSFNUUkVS
Uk9SPQogQUNfQ0hFQ0tfRlVOQyhbaHN0cmVycm9yXSwKICAgICBbXSwKLSAgICBbQUNfQ0hFQ0tf
TElCKFtyZXNvbHZdLCBbaHN0cmVycm9yXSwKLQlbTkVFRFNfUkVTT0xWPVllc1BsZWFzZV0sCi0J
W05PX0hTVFJFUlJPUj1ZZXNQbGVhc2VdKQorICAgIFtBQ19TRUFSQ0hfTElCUyhbaHN0cmVycm9y
XSwgW3Jlc29sdl0sCisgICAgICAgW05FRURTX1JFU09MVj1ZZXNQbGVhc2VdLAorICAgICAgIFtO
T19IU1RSRVJST1I9WWVzUGxlYXNlXSkKIF0pCiBHSVRfQ09ORl9TVUJTVChbTk9fSFNUUkVSUk9S
XSkKIAogZG5sIFRoaXMgbXVzdCBnbyBhZnRlciBhbGwgdGhlIHBvc3NpYmxlIHBsYWNlcyBmb3Ig
aXRzIGluaXRpYWxpemF0aW9uLAogZG5sIGluIHRoZSBBQ19DSEVDS19GVU5DIGludm9jYXRpb25z
IGFib3ZlLgogR0lUX0NPTkZfU1VCU1QoW05FRURTX1JFU09MVl0pCitHSVRfQ09ORl9TVUJTVChb
TkVFRFNfU09DS0VUXSkKK0dJVF9DT05GX1NVQlNUKFtORUVEU19OU0xdKQorCiAjCi0jIElmIGFu
eSBvZiB0aGUgYWJvdmUgdGVzdHMgZGV0ZXJtaW5lZCB0aGF0IC1scmVzb2x2IGlzIG5lZWRlZCBh
dAotIyBidWlsZC10aW1lLCBhbHNvIHNldCBpdCBoZXJlIGZvciByZW1haW5pbmcgY29uZmlndXJl
LXRpbWUgY2hlY2tzLgorIyBJZiBhbnkgb2YgdGhlIGFib3ZlIHRlc3RzIGRldGVybWluZWQgdGhh
dCAtbHJlc29sdiwgLWxzb2NrZXQgb3IgLWxuc2wKKyMgYXJlIG5lZWRlZCBhdCBidWlsZC10aW1l
LCBhbHNvIHNldCBpdCBoZXJlIGZvciByZW1haW5pbmcgY29uZmlndXJlLXRpbWUKKyMgY2hlY2tz
LiBUaGUgU3VuIG1hbiBwYWdlcyBsaXN0IGxpYnJhcnkgb3JkZXIgYXMgLWxyZXNvbHYgLWxzb2Nr
ZXQgLWxuc2wuCiB0ZXN0IC1uICIkTkVFRFNfUkVTT0xWIiAmJiBMSUJTPSIkTElCUyAtbHJlc29s
diIKK3Rlc3QgLW4gIiRORUVEU19TT0NLRVQiICYmIExJQlM9IiRMSUJTIC1sc29ja2V0IgordGVz
dCAtbiAiJE5FRURTX05TTCIgJiYgTElCUz0iJExJQlMgLWxuc2wiCisKIAogQUNfQ0hFQ0tfTElC
KFtjXSwgW2Jhc2VuYW1lXSwKIFtORUVEU19MSUJHRU49XSwK
--000000000000848795059dad7f75--
