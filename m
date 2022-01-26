Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC11C5DF62
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241125AbiAZMOm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 07:14:42 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:39129 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241122AbiAZMOl (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jan 2022 07:14:41 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C3DE73200993;
        Wed, 26 Jan 2022 07:14:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 26 Jan 2022 07:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=RrFW3pVt7gAPqsj88IbBgYcr+bbQOa
        hvtt/Fi6cHprU=; b=nGmIHdPkCQwYYqkoh5RpmyQDRrXzxEbF6gxFTW87npVvvx
        95KK8VoAbqj70RcxjIveg0pwppiQJaByGvNrY2qA3Hj2+UGq7+BBw9+IDH/FK0nl
        GDa4bpaM98PrkSj8TGOr6ZlqKN9h8ndVP6qVuYuFzA3bPUCw+ptnspQK7KBZqcVw
        clkkxqtF9e2Zw56lPo3gE2HndFIVLW4dZ3PE+iUQMZIsW7NDweZXjwv2MmWO8W/4
        usEwiDhKFD409cfuUAoJDLfTXFC/7gI1vme1YXQJ/OLSjA1g3357AcMYyge9Hglm
        8smSa1dlfx673tBFLbtJdiCK3tipcInnDN6HH7bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RrFW3p
        Vt7gAPqsj88IbBgYcr+bbQOahvtt/Fi6cHprU=; b=fOMFEfya8c6MvHqaKqs6CM
        623gHIHKOYTv8PznmPa3c1Eh51heVP6lLqZv5OY0uq/SH1atX17A9eg//TZLBYE+
        E2dx5lkpKmxPofM22dpvZyYg5qVrPMhu+qk85IuyjoRCVOOwvuFtXBBxNOfnP4an
        G1OEu1CP/VzHPhDDC+4FmQX07X8QLtfqC4SGQzvBZSwISH0a5DP8AObjpB7JelGf
        eVsPME7N72Rkb3gAdEvh01Z0ARoo//hHUDfT30/n/dJo5T1b4nt9cDP7UmOAnBdo
        dZKnG/s5rfOZ+vsu/ej0+e+JXM6PULVKP/2QE3StM5kN3OeZjrZ66v5vFuYrrMfg
        ==
X-ME-Sender: <xms:MDvxYXf9udOPX1d_hoc-O8mg8mgqZ4o8_wSDg1MAOBhLvA5uSFUFYA>
    <xme:MDvxYdPxk2OZMsJSCwwQ2E8TRFv3POY_AVVVV4_nv4DKftBY06qarcaNAAnomO3Ob
    U8ai9bks9V1OjHqN6Q>
X-ME-Received: <xmr:MDvxYQjhJTFW66bDyOmcRjhF5p7aKZ9qmj4NW_8xG4h5_HiAwdITizOWYX1lky3vydkck6p5auGM-etK6LhxKhKP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefirhgvghcujfhurhhrvghllhcuoehgrhgvgheshhhurhhrvghl
    lhdrnhgvtheqnecuggftrfgrthhtvghrnhepueetvdeiffdugeegheduhedtudefleejhe
    dttdetvdetfefhveekueduleehtdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:MDvxYY9skZ0eM3qNaeAwZgC_UirGMDJxRvTG3A2BhvOZnjqtt70cog>
    <xmx:MDvxYTt3ixAd6QSLCcgXkSpqVVusf2oUizVa7wOOJ2hOmAyWH8bwuA>
    <xmx:MDvxYXFiy-2z-Q-N8VU6JxlAN_SgBJT2kYyYMOMxTYPkxNy6e26XzA>
    <xmx:MDvxYcXaLT-iwzVyKShX7mMHYuV68eclOio4QdoOLQpZ60ykNhd7pg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jan 2022 07:14:39 -0500 (EST)
From:   Greg Hurrell <greg@hurrell.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Greg Hurrell <greg@hurrell.net>
Subject: [PATCH v2 1/2] Documentation/config/pgp.txt: replace stray <TAB> character with <SPC>
Date:   Wed, 26 Jan 2022 13:14:25 +0100
Message-Id: <20220126121426.53799-2-greg@hurrell.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220126121426.53799-1-greg@hurrell.net>
References: <220125.861r0vhh8r.gmgdl@evledraar.gmail.com>
 <20220126121426.53799-1-greg@hurrell.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Specifically, replace the tab between "the" and "first" with a space.

Signed-off-by: Greg Hurrell <greg@hurrell.net>
---
 Documentation/config/gpg.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 0cb189a077..abfabd6d62 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -37,7 +37,7 @@ gpg.minTrustLevel::
 gpg.ssh.defaultKeyCommand::
 	This command that will be run when user.signingkey is not set and a ssh
 	signature is requested. On successful exit a valid ssh public key is
-	expected in the	first line of its output. To automatically use the first
+	expected in the first line of its output. To automatically use the first
 	available key from your ssh-agent set this to "ssh-add -L".
 
 gpg.ssh.allowedSignersFile::
-- 
2.35.0

