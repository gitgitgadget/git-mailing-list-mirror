Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8126DC2BB41
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 11:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiHPLsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 07:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiHPLsD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 07:48:03 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F3792DABF
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=IXuCD
        TxJXrOX/pzCXkFokgpLqkY66vfMS/8nJ8Lklao=; b=Eg05BlCGvkhs90mevx41i
        MgENuHibyO6AGm1PUOhvWDWpj8bVG4x8o1HpQLbRW8lAtQMZRutFIz19h/TOqqmQ
        lp6V4qfv53rjODb9pVfUdd/5lrhtePJWGpsINt272wO6mN36HmmmRs/7tEMRJRpO
        icVJ1ncArIIaD2LqHH97io=
Received: from smtpclient.apple (unknown [122.9.237.141])
        by smtp2 (Coremail) with SMTP id GtxpCgBXBdvcfftiHpMJWA--.14607S3;
        Tue, 16 Aug 2022 19:22:06 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v4 1/3] hide-refs: add hook to force hide refs
From:   =?utf-8?B?5a2Z6LaF?= <16657101987@163.com>
In-Reply-To: <xmqqa6851ic9.fsf@gitster.g>
Date:   Tue, 16 Aug 2022 19:22:03 +0800
Cc:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Sun Chao <sunchao9@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB93B5DC-7F78-4A55-BBA4-7CB10CAAFEF3@163.com>
References: <pull.1301.v3.git.git.1660575384.gitgitgadget@gmail.com>
 <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
 <01c63ea5feefd57721bdcab9f0a30d9c0112e753.1660575688.git.gitgitgadget@gmail.com>
 <xmqqa6851ic9.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-CM-TRANSID: GtxpCgBXBdvcfftiHpMJWA--.14607S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFW3Cw4DWw4kXw4xGr17Jrb_yoWxGFW8pF
        WFkrZFyFsrJFyIyFnrZr1xZa48Zws5XFW3JrZag345AayYgFWxtFySgrWY9a47Cr4vga1j
        9rWUX3s5Ga4DZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeFAJUUUUU=
X-Originating-IP: [122.9.237.141]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiPhJfglxBtsQmCAABsx
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Aug 16, 2022, at 00:02, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Not "right now".
>=20
> Instead of flooding the list with repeated "oops that was wrong"
> updates, it may be more effective use of others' time to wait for
> more feedback before acting on them, and to take time to proofread
> the result of your updates before sending them out.
>=20
> Thanks.

Got it, I'll take more time in reviewing my patch updates in the future.

> On Aug 16, 2022, at 02:18, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> If the prefix is a sign to let the external process to tell if it is
> to be hidden or shown, it does not sound like "force" at all, at
> least to me ("force" sounds more like "no matter what other things
> may want to show it, these are hidden").

I=E2=80=99ve read the codes about refs hidden and I had 3 ideas in mind, =
but I
didn't know which is better: 1) create a new config item (like =
transfer.forceHideRefsByHook),
2) call `hide-refs` hook directly to check all refs if it exists, 3) add =
a new prefix option
to `transfer.hiderefs` to call the new hook.

I choose the third one but it is indeed hard to understand and the =
`force`
is not appropriate.

> Are there places where only ref_is_hidden() is called, or do
> codepaths that used to care ref_is_hidden() now all have to write
> the above (A || B) conditional?  I am wondering why the new
> "force-hidden" check is not part of ref_is_hidden() so that the
> callers do not have to care.
>=20
>> @@ -1794,7 +1794,8 @@ static void reject_updates_to_hidden(struct =
command *commands)
>> 		strbuf_setlen(&refname_full, prefix_len);
>> 		strbuf_addstr(&refname_full, cmd->ref_name);
>>=20
>> -		if (!ref_is_hidden(cmd->ref_name, refname_full.buf))
>> +		if (!ref_is_hidden(cmd->ref_name, refname_full.buf) &&
>> +			!ref_is_force_hidden(cmd->ref_name, =
refname_full.buf))
>=20
> Likewise.

In `mark_our_ref` I call ref_is_force_hidden() and ref_is_hidden() =
separately for a ref, and put
a new `HIDDEN_REF_FORCE` bit to the object flags if the ref is force =
hidden, then in `has_unreachable`
function the objects with this flag bit will be considered as 'not =
ancestors of our ref=E2=80=99. And
I do not want to change the original mechanism of ref_is_hidden(), this =
is why I add a new object
flag bit `HIDDEN_REF_FORCE`.

> It used to be that send_ref() did not touch the object flag bits.
> It just said "if it is hidden, or if it is outside the namespace, do
> not show and return" before telling the other side about the ref,
> and even the ref we send to the other side, we did not muck with
> flag bits with OUR_REF bit (and we didn't touch HIDDEN_REF bit,
> either).
>=20
> Now we do.  How can it be determined if this change is correct and
> safe?

I=E2=80=99m not very confident about the changes either so I have added =
some test cases for
upload-pack V1 and V2, but I think I need add more test cases for other =
commands after
considering your comment here.

>=20
> If the ref is not hidden (either in the traditional sense, or with
> the new "force" sense), we do not return 0.  What if it is outside
> the namespace so we returned without sending it to the other side?
> The original code didn't touch the flags bit, but now we mark the
> object with OUR_REF bit even though we ended up not sending the ref
> to the other side.  Is that an intended change?

Yes, this is a intended change here.

If I understand correctly, command `ls-refs` is called during protocol =
V2, I mark the object
flags here and use them when responding to command `fetch`, and I call =
`check_non_tip()`
before send the `want` data to the client which will check the force =
hidden objects.

>> +		if ((len >=3D forcelen) && !strncmp(value, "force:", =
forcelen)) {
>=20
> skip_prefix() would probably be a good API function to learn here, =
perhaps?
>=20

Will fix it.

>=20
>> +static struct child_process *hide_refs_proc;
>> +static struct packet_reader *hide_refs_reader;
>> +static void create_hide_refs_process(void) {
>=20
> Style.  The braces around a function block occupy their own line by
> themselves.
>=20
Will fix it. And I will read the style document again before update the =
patches.

>=20
> No need for braces around a single statement block.
>=20
Will fix it.

> Is that a condition worth dying, indicating a misconfiguration by
> the user?  Or would it make more sense to treat as if the process
> says no refs are hidden (or all refs are hidden)?

Thanks for your question here, I will think about it later. Just like =
`pre-receive` hook,
git server will skip it if it does not exists. I think we should not die =
here.

>=20
> I do not think we spell "cannot" as "can not" in our messages.

Will fix it.

>=20
>> +	proc =3D (struct child_process *) xcalloc (1, sizeof (struct =
child_process));
>> +	reader =3D (struct packet_reader *) xcalloc (1, sizeof(struct =
packet_reader));
>=20
> Style.  No SP after xcalloc, or sizeof.

Will fix it.

>> +	code =3D start_command(proc);
>> +	if (code)
>> +		die("can not run hook hide-refs");
>=20
> Unusually named variable.  I think "code" here is a variable
> normally called "status" (or "ret" if it eventually becomes the
> return value from this function).  Shouldn't this function return an
> error and have it handled by its caller, by the way, instead of
> returning void and making liberal calls to die()?

Will do.

>=20
>> +	code =3D packet_write_fmt_gently(proc->in, "version=3D1%c%s", =
'\0', hide_refs_section.buf);
>> +	if (!code)
>> +		code =3D packet_flush_gently(proc->in);
>=20
> In general, it is a bad pattern to hide mainline "good case"
> processing inside "if (previous steps all went fine)" conditionals,
> as it makes the code unnecessarily hard to follow.
>=20
> Instead, we typically write more like this:
>=20
> -- >8 -- cut here -- >8 --
>=20
> 	int ret =3D -1; /* assume failure */
>=20
>        if (packet_write_fmt_gently(...))
> 		goto error_exit;
>=20
> 	for (;;) {
> 		... interact with the other side ...
> 		if (error)
> 			goto error_exit;
> 	}
>=20
> 	... continue with mainline "good case" processing ...
>=20
> 	... after all went well ...
> 	ret =3D 0;
>=20
> error_exit:
> 	if (ret < 0) {
> 		... emit error message ...
> 		... clean-up specific to error case if necessary
> 	}
> 	... clean-up as needed ...
>=20
> 	return ret;
>=20
> -- 8< -- cut here -- 8< --
>=20
> I am not reviewing the rest of the patch in this sitting---I may
> later come back to continue reading it, but I'll stop here and send
> out comments on what I have seen first.
>=20
> Thanks.
>=20

Thanks a lot, I Will do it.

