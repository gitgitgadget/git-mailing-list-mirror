From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 3/4] reset: add option "--merge-safe" to "git reset"
Date: Thu, 17 Sep 2009 14:25:40 +0200
Message-ID: <c07716ae0909170525h21ab26f5y84b0fbce2192c69@mail.gmail.com>
References: <20090917040835.4048.51057.chriscool@tuxfamily.org>
	 <20090917041440.4048.16353.chriscool@tuxfamily.org>
	 <7vk4zykv7o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 14:26:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoG3w-0007PF-0Q
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 14:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbZIQMZj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 08:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbZIQMZj
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 08:25:39 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:50779 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbZIQMZi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 08:25:38 -0400
Received: by fxm17 with SMTP id 17so2933373fxm.37
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4v7RUp++dZOgPBCmzLVqKR7xPaEIvg7GXQavzzHgPtQ=;
        b=KYbJo4T6eh+LhdupcRwQm92NKpgxX8skfSvxYRg+wrbQBjWzNGuxHyLhoJhjNr2C5k
         lEyuX72xYJtIx6S+G3y2ilJZNYnecC77SWtVyKfzExdRTVP+dLHLRfN9NvG2Vq/pd5pz
         qRiez4b64jG/Sb2wFFaqgphpqcKJaQ5F8iuPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rrgzEdFBkGYFO+5Y6+P564705sSx8WqrDMhjfLJqyRwaHfeFNwfgyXV1ies3rpxHnh
         V9JRrp0pXl8If7ig3NzBSsRi7/c3IZc1c7H8/bvo7btXeDCWuwoBG+AsjivLTiBRtDUx
         hDjAqXoQfViDxpoanv0aprm/0rsC3rzjBTf58=
Received: by 10.204.2.205 with SMTP id 13mr327483bkk.205.1253190340852; Thu, 
	17 Sep 2009 05:25:40 -0700 (PDT)
In-Reply-To: <7vk4zykv7o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128747>

On Thu, Sep 17, 2009 at 7:15 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> From: Stephan Beyer <s-beyer@gmx.net>
>>
>> This option is nearly like "--merge" except that it is
>> safer.
>
> Do you still want to have this description after the last round?
>
>> The table below shows what happens when running
>> "git reset --option target" to reset the HEAD to another
>> commit (as a special case "target" could be the same as
>> HEAD) in the cases where "--merge" and "--merge-safe"
>> (abreviated --m-s) behave differently.
>>
>> working index HEAD target =A0 =A0 =A0 =A0 working index HEAD
>> =A0 B =A0 =A0 =A0B =A0 =A0 A =A0 =A0 A =A0 --m-s =A0 =A0 =A0B =A0 =A0=
 =A0A =A0 =A0 A
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--merge =A0 =A0A =
=A0 =A0 =A0A =A0 =A0 A
>> =A0 B =A0 =A0 =A0B =A0 =A0 A =A0 =A0 C =A0 --m-s =A0 =A0 =A0 (disall=
owed)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--merge =A0 =A0C =
=A0 =A0 =A0C =A0 =A0 C
>
> I'd like to see at least the following rows filled as well.
>
> =A0 =A0X =A0 =A0 =A0U =A0 =A0 A =A0 =A0 A =A0 --m-s =A0 =A0 =A0??? =A0=
 =A0??? =A0 ???
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --merge =A0 =A0??=
? =A0 =A0??? =A0 ???
> =A0 =A0X =A0 =A0 =A0U =A0 =A0 B =A0 =A0 A =A0 --m-s =A0 =A0 =A0??? =A0=
 =A0??? =A0 ???
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --merge =A0 =A0??=
? =A0 =A0??? =A0 ???
>
>> In this table, A, B and C are some different states of a file.
>
> ... and X is "don't care", and U is "unmerged index".

I will have a look, but it seems to me that --m-s and --merge
behave the same in these cases.

>> The code comes from the sequencer GSoC project:
>>
>> git://repo.or.cz/git/sbeyer.git
>>
>> (at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)
>>
>> But in the sequencer project the "reset" flag was set in the "struct
>> unpack_trees_options" passed to "unpack_trees()". With this flag the
>> changes in the working tree were discarded if the file was different
>> between HEAD and the reset target.
>
> If you need to have four lines worth of description here, is this sti=
ll
> Stephan's patch, or would it be more appropriate to say "This is base=
d on
> an earlier GSoC work by Stephan in git://repo.or.cz/git/sbeyer.git
> repository." and you take all the credit and blame?

As you insist, I will take all the credit and blame.

>> =A0static const char * const git_reset_usage[] =3D {
>> - =A0 =A0 "git reset [--mixed | --soft | --hard | --merge] [-q] [<co=
mmit>]",
>> + =A0 =A0 "git reset [--mixed | --soft | --hard | --merge | --merge-=
safe] [-q] [<commit>]",
>> =A0 =A0 =A0 "git reset [--mixed] <commit> [--] <paths>...",
>> =A0 =A0 =A0 NULL
>> =A0};
>
> As we established in the previous round, this is _different_ from --m=
erge,
> but *not* in the sense that --merge is more dangerous and users shoul=
d be
> using this new option instead, but in the sense that --merge perfectl=
y
> works well for its intended use case, and this new option triggers a =
mode
> of operation that is meant to be used in a completely different use c=
ase,
> which is unspecified in this series without documentation.
>
> In that light, is --merge-safe still a good name for the option, or m=
erely
> a misleading one?

I agree that it could be misleading. What about "--stash" ?

> As I said in the previous round, --merge discards the modified index =
state
> when switching, and it is absolutely _the right thing to do_ in the u=
se
> case it was intended for. =A0It is _not_ dangerous, and using --merge=
-safe
> in that scenario is not being _safe_ but is actively a _wrong_ thing =
to do.

Ok.

>> @@ -95,6 +98,16 @@ static int reset_index_file(const unsigned char *=
sha1, int reset_type, int quiet
>>
>> =A0 =A0 =A0 read_cache_unmerged();
>>
>> + =A0 =A0 if (reset_type =3D=3D MERGE_SAFE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned char *head_sha1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (get_sha1("HEAD", head_sha1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error("You do not h=
ave a valid HEAD.");
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (parse_and_init_tree_desc(head_sha1, de=
sc))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error("Failed to fi=
nd tree of HEAD.");
>> + =A0 =A0 =A0 =A0 =A0 =A0 nr++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 opts.fn =3D twoway_merge;
>> + =A0 =A0 }
>
> get_sha1() takes an allocated buffer, does not allocate space on its =
own.
> I think you meant "unsigned char head_sha1[20];" here.

Yes.

Thanks,
Christian.
