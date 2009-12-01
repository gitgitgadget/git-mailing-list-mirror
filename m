From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] get_ref_states: strdup entries and free util in stale 
	list
Date: Tue, 1 Dec 2009 10:32:37 +0100
Message-ID: <36ca99e90912010132iee0d42fo933aeb12833ad1ad@mail.gmail.com>
References: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com>
	 <7viqcrbl22.fsf@alter.siamese.dyndns.org>
	 <36ca99e90911302249r5f77f031o73cc7bb13dc375cf@mail.gmail.com>
	 <7vy6ln2llw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 10:32:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFP6D-0008KF-Fl
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 10:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690AbZLAJce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 04:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405AbZLAJcd
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 04:32:33 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42457 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbZLAJcc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 04:32:32 -0500
Received: by fxm5 with SMTP id 5so4654237fxm.28
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 01:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jtEINTHTqw8plxomsefkGk2Q98FIJLp5oKsUpXG+yw8=;
        b=oTPREQGKPd0tovRJxuX6VQOdQWqdCWbql7NuZ7v3qb0K2DoSt5JrroIxIbZqI/8t+F
         XqSQArqktt4qE0TP8Ahf1o7rUCtxOAJ4X4Z62FFFHdZOFc/GwtgAAOXyaiaC67tt0PcE
         GyXa8Es77dleH20zszy1jgDYwUgEcsIAezW0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cf2BZlSlja5qkIrisnp+z1TQdyKbuFbvPH0hu55lWbTHU2apDa1IOn0rqydVtUH0bW
         Wib+iI4SDEtmGTiMo5Wvfof3cj3nqJXyJWHgQU2KNBEyl11TlxqgC+EpdHfxjX79GoAt
         apo8U8vuzZmOoyMAHaVUP7YNOKQOv0tjqnVZY=
Received: by 10.223.161.205 with SMTP id s13mr875361fax.70.1259659957817; Tue, 
	01 Dec 2009 01:32:37 -0800 (PST)
In-Reply-To: <7vy6ln2llw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134188>

On Tue, Dec 1, 2009 at 08:34, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> On Tue, Dec 1, 2009 at 01:21, Junio C Hamano <gitster@pobox.com> wro=
te:
>> ...
>>> Hmm, the Subject: matches what the code does, but nobody mentions w=
hy it
>>> is necessary (iow, what breaks in the current code and what becomes=
 better
>>> if the patch is applied). The blank space before your "S-o-b:" line=
 is
>>> for you to describe these things.
>> Sure. unfortunately the code where the string list is filled is not =
in
>> the patch. But if you look at the code it should be self-explanatory=
=2E
>
> That is _exactly_ why I want the description in the commit log messag=
e. =C2=A0I
> don't want commit messages (or lack thereof) to force people to look =
at
> the code outside the patch.
>
> Otherwise I'll have to ask _you_ to personally give the 7-line explan=
ation
> you just gave us to anybody who runs "git log -p" with the default co=
ntext
> size after this patch is applied. =C2=A0I do not think you have the b=
andwidth
> to handle that ;-).
Yes. That makes perfectly sense. Sorry for the hassle.

>
>> There is actually also an other solution: we could first strdup the
>> ref name to the .util member and take this as the input for the
>> abbrev_ref()/string list entry and safe there the strdup.
>
> I too thought something like that may make sense, but it doesn't look=
 like
> so, for two reasons:
>
> =C2=A0- string-list API is a bit cumbersome to use if you allocate th=
e string
> =C2=A0 yourself. =C2=A0You will be made responsible for freeing them,=
 and often you
> =C2=A0 do so by setting strdup_strings to true immediately before cal=
ling
> =C2=A0 string_list_clear(), which is kind of ugly;
>
> =C2=A0- The ref abbrev_branch() is called and the address of whose su=
bstring is
> =C2=A0 taken to be used as "name" in handle_one_branch() is refspec.s=
rc, but
> =C2=A0 what goes to .util is refname that is refspec.dst---they are d=
ifferent
> =C2=A0 strings and one is not a substring of the other.
I don't see you point here. The current code is:

	for (ref =3D stale_refs; ref; ref =3D ref->next) {
		struct string_list_item *item =3D
			string_list_append(abbrev_branch(ref->name), &states->stale);
		item->util =3D xstrdup(ref->name);
	}
So 0 =3D=3D strcmp(item->string, abbrev_ref(item->util, "refs/heads/"))
should be true, shouldn't it?

Bert
