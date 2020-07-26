Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35840C433DF
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 17:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1536E206D8
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 17:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gcRVfD7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgGZRla (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 13:41:30 -0400
Received: from mout.web.de ([212.227.15.14]:41739 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGZRl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 13:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595785269;
        bh=Ds27fyq8EUlcXBTjMCCOljcMoZZKXgXNXgr9Y7Q5O4k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gcRVfD7XMLPK+BSwGhbOeP1qAq76wzrVV1E4SMfTWJM03gRBLNJmuyse9rr3+zfyM
         Ne+DjDnafse1Z+HOhWbmO4xX/eoGzGdfmDx7Bki7gp1hlX7oz30llThWeuCOOnYVyM
         02wuDxZ2ftlL0sCrgatQOecsq7vjP0Ib8n/CuBQk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1d7s-1kwz891lg8-011zc1; Sun, 26
 Jul 2020 19:41:09 +0200
Subject: Re: [PATCH v2 2/2] hex: make hash_to_hex_algop() and friends
 thread-safe
To:     Matheus Tavares <matheus.bernardino@usp.br>,
        johannes.schindelin@gmx.de
Cc:     christian.couder@gmail.com, frekui@gmail.com, git@vger.kernel.org,
        j6t@kdbg.org, jonathantanmy@google.com, peff@peff.net,
        sandals@crustytoothpaste.net
References: <nycvar.QRO.7.76.6.2007161214270.54@tvgsbejvaqbjf.bet>
 <20200718035201.42233-1-matheus.bernardino@usp.br>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a35a9334-6db2-d8e3-8ce5-15f15a9005e1@web.de>
Date:   Sun, 26 Jul 2020 19:41:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200718035201.42233-1-matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n4TTDH/GQITZLC3XbC4g45A/O4NjcqHtqIBWPMtCCSJpaSWjVYo
 DlUpd+3t+KgsdB+L3yPWjr7CxrRY855W0COesJMtS3Miq0RqetcFuli0jbR3xkHquDtQaGd
 94nXFsM1o2Y2F6S+aka2X6w9U4j/ndOIxklNWbAkyzVJ7Ve9RuM9ecyuyNxaMVv7LTdxZvO
 BScmskcLACgFDwpxwuw2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FPqWHHyuBKc=:E7wrGesDHIvtBXietyVyOG
 5B4aAyOiNEb7hUPqaWU0VKttN3GN49UtpNzO+UOqJeFAiynX1/3IL/sni0CduQUvBoWuTwwJ/
 AnSGc7X6IMMmO4gLRsauze13iaOu5pOGz/dGOj9HnoT/3hrWkAV66xJMvsAbklGqlDgNO6umj
 CfkrAqQE2QwNi4rtf1PE3yCC3/mPfoSpPpFYpDC1pbGnUz/ydkvKfaXfyiBB65/iByJqjYa9s
 hDMwIUFZOyWhKm+JAm6SkhwRnQ3k6oQ5mYLhJLdkmTVF/188Asy2j9cT5ocWeFNYBcaLRWCX+
 BJShIEInGUydno7RkOiRj2wnTlCo0uG0WVAcu7DVSb4kdVrAW0f5SH+VAxDLMMYK4r2qE06Aa
 wFToU8TVPFg/f2JdjLG0rs7TkYrjdtzBij5I53xVH+9g69TDbfjFOcviwicsLJadn0gnp199R
 a3wo+MmOV3Xjl8dpvJH+QwdFfNPIGGuzIzqcbHE3LqKmaWY6/pRRqosSFLbuFINGlW6IQFgAO
 atYDmwBoKGtalghkwXxn3LD/pCE5aYZCZ9NoKWtIqoi+NvfC/eJlp4avz3AWtb7/o8FVOWmCK
 MMQZxbhu/imrlEmD1Jxzp+/Hj/xL+B3pn9J1lOMR+jPuNg5r599a+j7L4bbe/Idfa7co4lQbi
 A0PvQ9IhPD2gYvqxcDBbOBjGzO/Tl/dkm2BsidBwkqSeiVPr+jOb3ye4JOHFYhGGSgXP65c6k
 ykgpyHN7IWMLcv9BGzrfJomqyg7k2YtD2FdfUTVycszZAiPB733EE4d9rcbH4DCsDwFjMOEob
 X1K30d2AxBFiYISwZ/0i0ykAG450Z3Yend4UDGAgF+JC7vyvCWktZkiirsQ5aGUyoIdaCc2Km
 90cnmM6chD9qq1sFTDymbPF8EgqaA1dpfSDPPZBsoJAe/oonF21fXxGgt3e5RecHwFdSTXLKT
 Nooauxp/qX2m/nPirff5VwFGdNgXdvuvZv1TGQ17ShhbDZPUFhMYXx4bAf8CxwCwt9bdLYMqC
 BXYlvrJ9TlLzvH+0w9gCCvv+wIOhZXfIBhpYyOIxLS2mp9etTtkck24bzj+MXoN8euEi+0ALb
 NWTYH7Tz+Fc2WqhRuht/1wSM8dCKzPEneozfjMUEeH0ODghmbPIzSCLJAgygh7ShbM5Lwpy5w
 2uWfutdEVxeHhzj9aIVVPoBlTTNq67AghJDAuCjuVqvBvQDQxmfYWqZpTcOx8844jxUiYzbRK
 etXxk+NrIpHXW6WrT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.07.20 um 05:52 schrieb Matheus Tavares:
> On Thu, Jul 16, 2020 at 9:56 AM Johannes Schindelin <Johannes.Schindelin=
@gmx.de> wrote:
>>
>> Now, I am _far_ from knowing what I'm doing with Coccinelle, but I thin=
k
>> this here semantic patch should get you going:
>>
>> -- snipsnap --
>> @@
>> expression E;
>> @@
>> =C2=A0 {
>> ++ =C2=A0 char hex[GIT_MAX_HEXSZ + 1];
>> =C2=A0 =C2=A0 =C2=A0...
>> - =C2=A0 =C2=A0oid_to_hex(E)
>> + =C2=A0 =C2=A0oid_to_hex_r(hex, E)
>> =C2=A0 =C2=A0 =C2=A0...
>> =C2=A0 }
>>
>> @@
>> expression E1, E2;
>> @@
>> =C2=A0 {
>> ++ =C2=A0 char hex1[GIT_MAX_HEXSZ + 1], hex2[GIT_MAX_HEXSZ + 1];
>> =C2=A0 =C2=A0 =C2=A0...
>> - =C2=A0 =C2=A0oid_to_hex(E1)
>> + =C2=A0 =C2=A0oid_to_hex_r(hex1, E1)
>> =C2=A0 =C2=A0 =C2=A0...
>> - =C2=A0 =C2=A0oid_to_hex(E2)
>> + =C2=A0 =C2=A0oid_to_hex_r(hex2, E2)
>> =C2=A0 =C2=A0 =C2=A0...
>> =C2=A0 }
>
> Thanks for this nice example! This already worked very well in some of
> my tests :)
>
> However, with my _very_ limited notion of Coccinelle, I didn't
> understand why some code snippets didn't match the above rules. For
> example, the structure below:
>
> func(...)
> {
> 	if (cond)
> 		func2("%s", oid_to_hex(a));
> }
>
> I thought it could be because the `if` statement is missing the curly
> brackets (and it does work if I add the brackets), but to my surprise,
> adding another oid_to_hex() call in an `else` case also made the code
> match the rule:
>
> func(...)
> {
> 	if (cond)
> 		func2("%s", oid_to_hex(a));
> 	else
> 		func2("%s", oid_to_hex(a));
> }
>
> The following snippet also correctly matches, but spatch introduces only
> one `hex` variable:
>
> 	if (cond)
> 		func2("%s, %s", oid_to_hex(a), oid_to_hex(b));
> 	else
> 		func2("%s", oid_to_hex(a));
>

The produced diff looks like this:

+	char hex[GIT_MAX_HEXSZ + 1];
 	if (cond)
-		func2("%s, %s", oid_to_hex(a), oid_to_hex(b));
+		func2("%s, %s", oid_to_hex_r(hex, a), oid_to_hex_r(hex, b));
 	else
-		func2("%s", oid_to_hex(a));
+		func2("%s", oid_to_hex_r(hex, a));

So the first rule was applied (the one for a single oid_to_hex call),
but we need the second one (for two oid_to_hex calls).  Using the same
hex buffer for two different values won't work.

> We will probably want our semantic rules to handle an arbitrary number
> of `oid_to_hex()` calls in each function, but in scenarios like the
> above one, we only really need 2 hex buffers despite having 3 calls...

oid_to_hex() has two interesting features, and we need to make sure they
are preserved for callers that use them: It has a ring of four buffers,
so you can use it for four different values, and those buffers are
static, so its results can be passed around arbitrarily.

> That might be a little tricky, I guess.

It may be impossible to cover all cases.  E.g. callers of oid_to_hex()
could return that buffer (like e.g. diff_aligned_abbrev()) or save
them in some global variable (like e.g. string_list_append() with a
non-DUP string_list).  But safe conversion rules can got us surprisingly
far.

> Another thing that might be tricky in this conversion is checking for
> name conflicts with the added `hex` variable (but maybe Coccinelle
> already has a facilitator mechanism for such cases? IDK).

That's easy.  There exists no hex_buffer, yet.  We can just claim that
name for automatic conversions.  It's a bit too long for people to
type out (we have a few variables named hexbuffer, though), but not
crazy long.

So what is safe?  Calls of oid_to_hex() in the argument list of many
functions is.  E.g. puts() and printf() just consume the string that
is passed to them, and they don't store it anywhere.  That means no
static storage is needed for those.

string_list_append() is only safe if it's the duplicating variant.
Since this is a runtime option of the underlying string_list this is
hard to prove in a Coccinelle rule.  The time is better spent
converting them manually, I think.

And function calls with more than four oid_to_hex() calls are broken
already, so we only need to have rules for up to four of them.  Here
is the simplest rule I can come up with for handling up to four
oid_to_hex() calls:

@@
identifier fn =3D~ "^(.*printf.*|puts)$";
@@
(
  fn(...,
-   oid_to_hex
+   oid_to_hex_r
    (
+     hex_buffer,
      ...
    ), ...,
-   oid_to_hex
+   oid_to_hex_r
    (
+     hex_buffer2,
      ...
    ), ...,
-   oid_to_hex
+   oid_to_hex_r
    (
+     hex_buffer3,
      ...
    ), ...,
-   oid_to_hex
+   oid_to_hex_r
    (
+     hex_buffer4,
      ...
    ), ...
  )
|
  fn(...,
-   oid_to_hex
+   oid_to_hex_r
    (
+     hex_buffer,
      ...
    ), ...,
-   oid_to_hex
+   oid_to_hex_r
    (
+     hex_buffer2,
      ...
    ), ...,
-   oid_to_hex
+   oid_to_hex_r
    (
+     hex_buffer3,
      ...
    ), ...
  )
|
  fn(...,
-   oid_to_hex
+   oid_to_hex_r
    (
+     hex_buffer,
      ...
    ), ...,
-   oid_to_hex
+   oid_to_hex_r
    (
+     hex_buffer2,
      ...
    ), ...
  )
|
  fn(...,
-   oid_to_hex
+   oid_to_hex_r
    (
+     hex_buffer,
      ...
    ), ...
  )
)

So the sub-rules are ordered from matching all four possible
oid_to_hex() calls down to a single one.  Only safe consumers are
matched.  That regex can and should be extended.

Having a list of good consumers has the nice side-effect of speeding up
the diff generation.  It still takes a few minutes on my system, though.

We still need to declare of the local buffers.  We can add them on
demand to each function with rules like this:

@avoid_duplicates@
identifier buf =3D~ "^hex_buffer[2-4]?$";
@@
- char buf[GIT_MAX_HEXSZ + 1];

@hex_buffer4_on_demand exists@
identifier fn;
@@
  fn(...) {
+   char hex_buffer4[GIT_MAX_HEXSZ + 1];
    <+... hex_buffer4 ...+>
  }

@hex_buffer3_on_demand exists@
identifier fn;
@@
  fn(...) {
+   char hex_buffer3[GIT_MAX_HEXSZ + 1];
    <+... hex_buffer3 ...+>
  }

@hex_buffer2_on_demand exists@
identifier fn;
@@
  fn(...) {
+   char hex_buffer2[GIT_MAX_HEXSZ + 1];
    <+... hex_buffer2 ...+>
  }

@hex_buffer_on_demand exists@
identifier fn;
@@
  fn(...) {
+   char hex_buffer[GIT_MAX_HEXSZ + 1];
    <+... hex_buffer ...+>
  }

Why remove them first?  To avoid duplicates when other convertible
oid_to_hex() calls are added later and the semantic patch applied
again.

Why declare the buffers with function scope?  To avoid shadowing.

Why are the rules reversed?  They add declarations at the top, so
hex_buffer to hex_buffer4 end up being declared in that order in
the resulting file.

Why not use the "fresh identifier" feature of Coccinelle to generate
an unused name each time?  I don't know how to integrate that into
the 4/3/2/1 rule above without having to repeat the list of safe
consumers or declaring unused buffers.  And reusing buffers between
safe consumers is fine.

Ren=C3=A9
