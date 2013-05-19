From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/WIP 0/9] for-each-ref format improvements
Date: Sun, 19 May 2013 18:54:05 +0700
Message-ID: <CACsJy8DMF3NzvMRUO56H+EwpXSjmY9qzdNdv9cGJ9XxUO=ekJA@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com> <CALkWK0=7z91A54jSzc2yZU3g50u8H_f8su1Y+i=D+KxYtqor5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:54:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2CG-0007U3-Sw
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460Ab3ESLyh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 07:54:37 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:62057 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387Ab3ESLyg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:54:36 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so6638532oag.20
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=w9pR9o3hKuAavfE98gQ0Ymh9VsS9aUJf59vV8hUyEXg=;
        b=lAAJFQlwd4vFUjVrMx7o8NSI25IuZpAI/FfVOahJUDQ0lx7FXL9su0O7lzl0wEowHO
         ldyApjjaG+fWLk7CgRHZ+fsP+BHRyUyCvvdx1sFwHfyEtJelqgcDVfJKSfqmyvZMd24h
         jeRMhOiSkNHwUnPz1OH7YEGnlsqFixXdG+8oQIiv6RmqCPxzjKoCEfnn2hvwQefOrZ+D
         q+a3FW+0VI4vPcRi6oHHVTj3htuVlj5pF5sK8nJHYXTGkMTjkbYgcoORWG2Bsk4/zmwX
         wkD+WSI4BZSNdA0U/6J3Z4pVVvJTIl35/yfiYFv4K6lKp9hP1rVVUM826RLNtwS60Mrg
         26og==
X-Received: by 10.182.56.131 with SMTP id a3mr3223746obq.38.1368964476048;
 Sun, 19 May 2013 04:54:36 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Sun, 19 May 2013 04:54:05 -0700 (PDT)
In-Reply-To: <CALkWK0=7z91A54jSzc2yZU3g50u8H_f8su1Y+i=D+KxYtqor5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224871>

On Sun, May 19, 2013 at 6:11 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> The purpose of this series is to make "for-each-ref --format" powerf=
ul
>> enough to display what "branch -v" and "branch -vv" do so that we
>> could get rid of those display code and use for-each-ref code instea=
d.
>
> Damn, you beat me to it.  I just introduced color, and was working on
> alignment.  See $gmane/224692.

Hmm.. I missed that mail (or I wouldn't have worked on this already).
Do you want to take over?

>>  - %(tracking[:upstream]) gives us the exact output that branch -v[v=
]
>>    does. %(upstream) does not include []. We can't change its
>>    semantics.
>
> There's already an atom called "upstream", and "upstream:short" works=
=2E
>  Why not introduce "upstream:diff" for "[ahead x, behind y]" and
> "upstream:shortdiff" for "<>" (like in the prompt)?

"branch -vv" shows [upstream: ahead x, behind y]. We need a syntax to
cover that too.

>>  - %(color:...) is pretty much the same as %C family in pretty code.
>>    I haven't added code for %(color:foo) =3D=3D %C(foo) yet. There's=
 a
>>    potential ambiguity here: %C(red) =3D=3D %Cred or %C(red)??
>
> I'd vote for dropping %C<name> altogether and just go with %C(<name>)=
=2E
>  Why do we need %(color:<name>) at all?

pretty and for-each-ref format seem to be on the opposite: one is
terse, one verbose. Unless you are going to introduce a lot of new
specifiers (and in the worst case, bring all pretty specifiers over,
unify underlying code), I think we should stick with %(xx) convention.

>>  - %(...:aligned) to do left aligning. I'm not entirely sure about
>>    this. We might be able to share code with %>, %< and %>< from
>>    pretty.c. But we need improvements there too because in
>>    for-each-ref case, we could calculate column width but %< would
>>    require the user to specify the width.
>
> Yeah, I think we should go with the %> and %< you introduced in
> pretty.c.  Yes, I want to be able to specify width.

I still think we should follow %(...), e.g. %(left:N), %(right:N) as
equivalent of %< and %>...

>>    Do people expect fancy layout with for-each-ref (and branch)? If =
so
>>    we might need to have %(align) or something instead of the simple
>>    left alignment case in %(...:aligned)
>
> Why should we deviate from the pretty case?  What is different here?

Laziness plays a big factor :) So again, you want to take over? ;)

>>  - We may need an equivalent of the space following % in pretty
>>    format. If the specifier produces something, then prepend a space=
,
>>    otherwise produce nothing. Do it like %C( tracking) vs
>>    %C(tracking)??
>
> Yeah, sounds good.
>
>> You can try this after applying the series, which should give you th=
e
>> about close to 'branch -v'. %(tracking) coloring does not work thoug=
h.
>
> Why doesn't %(tracking) coloring work?

it uses builtin/branch.c:branch_use_color. Eventually
fill_tracking_info() should be moved to for-each-ref.c and pass
branch_use_color in as an argument. But for now, I just leave it
broken.
--
Duy
