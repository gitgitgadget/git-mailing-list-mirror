Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA917C433E1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DF0204EA
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RPAwrOAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgGZWPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 18:15:12 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33883 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgGZWPM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 18:15:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 397135C00B0;
        Sun, 26 Jul 2020 18:15:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 26 Jul 2020 18:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=9Y9TEwiaxUcg6WP4I4RUXLRGOG6Cfy2i+rXQs26I5
        Ok=; b=RPAwrOASDnfrGo8oXZpnzp1Fa29G/FkwtNgMlVOMsS3DcZoGxu8XTRyfr
        5Fx43CrCELXZMJxF4uNe+6VwOV4FMrwy4dX2NWTgDwvUQLSncTswz738Tg2j4WE6
        MH7DzaultbjrnX/s7mB2h6wTFCPe4vKYBhL2VjBb/XP0fnivYa8hQiNKoHLPjgzj
        1hONtlyQV8yQ6AYuUSV6iBYA0pdYljCtWyNueqsltWYr1NWn9RgaTaH/VrSdi7AS
        DKJsJAua1keawXiI1c6pctlDVbWECLjoVjfgO5ahC3z098+pqvRnQJ4MH904Swmt
        dI8vn+VsFTnfbtlZnkxIMTr9bGw4Q==
X-ME-Sender: <xms:bgAeX3Ib7lOfzsLannzH4l7cdrmxmXGZ7KTqJnyRX0DLSHFwMw3tDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjfgesthekredttderudenucfhrhhomhepfdflrdcu
    rfgruhhlucftvggvugdfuceophhrvggvugesshhighhkihhllhdrtghomheqnecuggftrf
    grthhtvghrnhepleetfedvkeffkeevjeefieduvdehveegieduleffudffgffgfefhveef
    veelfedtnecuffhomhgrihhnpehjphgruhhlrhgvvggurdgtohhmnecukfhppeeiledrud
    ekuddrfeegrddvfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhrvggvugesshhighhkihhllhdrtghomh
X-ME-Proxy: <xmx:bgAeX7I3GBqUW7bNVEolbqz1qYrWzVnzKCnqFbqmGwmweHftSLwwbQ>
    <xmx:bgAeX_v60YkZ75U7tMab9g3otjNXTH6C4g4VnV3vlsiaJZLZHlqhTw>
    <xmx:bgAeXwbLLKTbLRCzsr4ygAOvf2chU5LqgWdaxpSE45wWJ6_b7HpVNQ>
    <xmx:bwAeX9m9l7diiM3YSjadzV4iRPEWxyzCYTrH_JCJSMKhfyEbyEUZIA>
Received: from sigkill.com (c-69-181-34-234.hsd1.ca.comcast.net [69.181.34.234])
        by mail.messagingengine.com (Postfix) with ESMTPA id 459C43280065;
        Sun, 26 Jul 2020 18:15:10 -0400 (EDT)
Date:   Sun, 26 Jul 2020 15:15:08 -0700
From:   "J. Paul Reed" <preed@sigkill.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-gui patch staging errors
Message-ID: <20200726221508.GA8735@sigkill.com>
References: <20200512010750.GA7127@sigkill.com>
 <20200512121511.dyyd6n5gdfbesy2j@yadavpratyush.com>
 <AM0PR02MB371505CA3EE36FBDB44B3A409CBE0@AM0PR02MB3715.eurprd02.prod.outlook.com>
 <20200512204233.GA31807@sigkill.com>
 <20200525130807.4ydporgaeva27del@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200525130807.4ydporgaeva27del@yadavpratyush.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hey Pratyush,

Apologies for the late reply myself! Oof... been a long couple of months.

See further responses inline:

later,
preed
-- 
J. Paul Reed
https://jpaulreed.com
PGP: 0xDF8708F8

On 25 May 2020 at 18:38:07, Pratyush Yadav arranged the bits on my disk to say:

> Hi,
> 
> Sorry for the late reply.
> 
> On 12/05/20 01:42PM, J. Paul Reed wrote:
> > 
> > Hey Richard,
> 
> You replied to the wrong person ;-)

Sorry about that!

> I suspect it is some encoding mismatch. Can you apply this patch below 
> and send what the output is?
> 
> -- 8< --
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index 871ad48..6226a89 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -851,8 +851,13 @@ proc apply_or_revert_range_or_line {x y revert} {
>  		set first_l [$ui_diff index "$next_l + 1 lines"]
>  	}
>  
> +	puts "Diff we will send to git-apply:"
> +	puts -nonewline "$current_diff_header"
> +	puts -nonewline "$wholepatch"
> +
>  	if {[catch {
>  		set enc [get_path_encoding $current_diff_path]
> +		puts "\nEncoding: $enc"
>  		set p [eval git_write $apply_cmd]
>  		fconfigure $p -translation binary -encoding $enc
>  		puts -nonewline $p $current_diff_header
> -- >8 --

Here ya go:

[preed@underworld aws-glacier-multipart-upload]$ ~/checkouts/git-gui/git-gui.sh 
Diff we will send to git-apply:
diff --git a/glacierupload.sh b/glacierupload.sh
index 3b956c7..c83150c 100755
--- a/glacierupload.sh
+++ b/glacierupload.sh
@@ -58,15 +58,14 @@
 # count the number of files that begin with "$prefix"
 fileCount=$(ls -1 | grep "^$prefix" | wc -l)
 echo "ð¦ Glacier Upload with $AWS_PROFILE"
 echo "Total parts to upload: " $fileCount
 
 # get the list of part files to upload.  Edit this if you chose a
 # different prefix in the split command
 files=$(ls | grep "^$prefix")
 
 # initiate multipart upload connection to glacier
-echo aws glacier initiate-multipart-upload --profile $AWS_PROFILE
--account-id - --part-size $byteSize --vault-name $vaultName
--archive-description "$description"
 init=$(aws glacier initiate-multipart-upload --profile $AWS_PROFILE
--account-id - --part-size $byteSize --vault-name $vaultName
--archive-description "$description")
 
 echo "---------------------------------------"
 # xargs trims off the quotes
 # jq pulls out the json element titled uploadId

Encoding: utf-8

This is probably expected, but to be clear: with this patch, I do still get
the error popup in the gui ("Failed to stage selected line; error: patch
failed: glacierupload:58 error: glacierupload.sh patch does not apply"
