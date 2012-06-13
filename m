From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] git bisect old/new
Date: Wed, 13 Jun 2012 12:12:21 +0200
Message-ID: <CAP8UFD1=phEzzwRBmwsLqnbM0_yAS+uMXma_uyqfdq3xo4fTGw@mail.gmail.com>
References: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
	<CAP8UFD1mgKNQRZpuqYgyL__DGpoZ3cOGJC0amoqWT+1Bn_0iTg@mail.gmail.com>
	<7v1ull5bld.fsf@alter.siamese.dyndns.org>
	<CABURp0rWu0GtmSrLV+qEQJVYOt8p=B4bQtG3fzKh2f0fTGHwOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	git@vger.kernel.org, Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 12:12:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SekYw-0008AE-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 12:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab2FMKMX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 06:12:23 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33785 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab2FMKMW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 06:12:22 -0400
Received: by pbbrp8 with SMTP id rp8so2083390pbb.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dt/euqi7aXW1LcOmgMGg5y74r/BUuAMmi4AgcqWnw9o=;
        b=TqZsi6YBWsyTjeFoCaelyzEzd2NKlx9nET1BiPqom7XUQrOJUGYjJ4dKdyvU1A+i7B
         9lJgP/8msGcYN/WarIf2A96dyVOnv0hscr1T1q5sv3JPvrayJxowl5BsitKqG2tpVWX6
         bb0QRrtdqaCvWt2YW9Qx63HWm7b9dGj7SswKkVJdNLorpA9nGS4YbxBSSjeR367/r1jf
         ic77KjzUWUsrkeKL/6eP443PrZ/9e7yfCoWCaLaR5Qyz4RJ8CCISAnCFhZtIIDnmN9ya
         o2O7WZbHF+GmrFIyjFkb/wxIEKxGCp8k64I3aqrYVR3w/KqV1ynqRgbh3b8PCG+goSIF
         QW8w==
Received: by 10.68.136.229 with SMTP id qd5mr49682812pbb.2.1339582341462; Wed,
 13 Jun 2012 03:12:21 -0700 (PDT)
Received: by 10.142.234.9 with HTTP; Wed, 13 Jun 2012 03:12:21 -0700 (PDT)
In-Reply-To: <CABURp0rWu0GtmSrLV+qEQJVYOt8p=B4bQtG3fzKh2f0fTGHwOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199885>

On Tue, Jun 12, 2012 at 9:41 PM, Phil Hord <phil.hord@gmail.com> wrote:
> On Tue, Jun 12, 2012 at 1:43 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>
>> >> @@ -403,9 +406,10 @@ struct commit_list *find_bisection(struct
>> >> commit_list *list,
>> >> =A0static int register_ref(const char *refname, const unsigned ch=
ar
>> >> *sha1,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int flags, void *c=
b_data)
>> >> =A0{
>> >> - =A0 =A0 =A0 if (!strcmp(refname, "bad")) {
>> >> + =A0 =A0 =A0 if (!strcmp(refname, bisect_term_bad)) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0current_bad_sha1 =3D sha1;
>> >> - =A0 =A0 =A0 } else if (!prefixcmp(refname, "good-")) {
>> >> + =A0 =A0 =A0 } else if (!prefixcmp(refname, "good-") ||
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !prefixcmp(refname,=
 "old-")) {
>> >
>> > I don't like very much "good" and "old" to be hardcoded here.
>>
>> Really?
>
> I tend to agree. =A0But I like more generic code and less hard-coded =
in
> almost all cases.

Yeah, I prefer generic code too.

>> >> @@ -731,18 +735,25 @@ static void handle_bad_merge_base(void)
>> >> =A0 =A0 =A0 =A0if (is_expected_rev(current_bad_sha1)) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *bad_hex =3D sha1_to_hex(curr=
ent_bad_sha1);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *good_hex =3D join_sha1_array=
_hex(&good_revs, ' ');
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(bisect_term_bad,"bad"))=
 {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "Th=
e merge base %s is bad.\n"
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Th=
is means the bug has been fixed "
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "be=
tween %s and [%s].\n",
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad=
_hex, bad_hex, good_hex);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "Th=
e merge base %s is new.\n"
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Th=
e property has changed "
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "be=
tween %s and [%s].\n",
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad=
_hex, bad_hex, good_hex);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >
>> > I don't like very much "new" to be harcoded here too.
>>
>> Why not? =A0It is not like we will be adding any more synonym pair
>> beyond good/bad, so...
>
> Previously we discussed using yes/no, among others.
> http://permalink.gmane.org/gmane.comp.version-control.git/182496

And even if we add "yes/no" maybe people will still want to use
"good/bad" instead of "bad/good", "new/old" or "yes/no".

Thanks,
Christian.
