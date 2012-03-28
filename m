From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 9/9 v8] difftool: print list of valid tools with '--tool-help'
Date: Wed, 28 Mar 2012 15:48:05 -0400
Message-ID: <CAFouetjbq+A04HECXN39KeLBgkTd+HJyxeM0wSDhS2Xo=_gQVQ@mail.gmail.com>
References: <1332959684-2231-1-git-send-email-tim.henigan@gmail.com>
	<7vvclov9hi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davvid@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:48:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyqq-000709-Ig
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758489Ab2C1TsH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 15:48:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56916 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758381Ab2C1TsF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2012 15:48:05 -0400
Received: by iagz16 with SMTP id z16so1900625iag.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 12:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=30wGl3jfKY2SFivAK9K9ngOPF1zuqEvyzOno7FpQeX4=;
        b=JuZn4zoY3Rya1o9z4sENxHTTvAZcS2kn+5AZcAXXEQhHvVziv3ouhYSfL+04+wxa/2
         oIU0PrTcX60Xqfq6HDLek8BnsUjTqRW+Zrqabnl/cqnijn2vCbVTWSMQv0tj2RnrPitJ
         HwUU+KIHhnNR2AOEe+yn4g38ZRgnPB1mzHhAz15vAJomV9HPiifaim0qi4BVyZWzFIo8
         GsjDq4mzOYkR63kRDh3ymn1YhpU14qCoz1feT52yFjt/7BmvnQVWjA3JMdGloRy9hY85
         gvZ06sh99eSt6dp3BtYw0zJ3axn6U66ff/TducS/Jf4f6SWgyO53v2R9g/5dw3uFy7Ye
         DGfg==
Received: by 10.50.188.138 with SMTP id ga10mr264439igc.51.1332964085129; Wed,
 28 Mar 2012 12:48:05 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Wed, 28 Mar 2012 12:48:05 -0700 (PDT)
In-Reply-To: <7vvclov9hi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194176>

On Wed, Mar 28, 2012 at 2:58 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
> OK, but doesn't File::Find recurse into its subdirectories? =C2=A0If =
you create
> a 'foo' directory there and drop a 'bar' script in it, is the rest of=
 the
> code prepared to give you "git difftool -t foo/bar"?

It does recurse, but in this context '$_' only contains the current
file name within the directory...not the directory itself [1].  So if
we call 'find' on a directory that contains:

  foo
  bar/
      baz

then @tools =3D ('foo', 'baz')

[1]: http://perldoc.perl.org/File/Find.html#The-wanted-function


>> + =C2=A0 =C2=A0 for (@tools) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 my $tool =3D $_;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next if ($tool eq "defau=
lts");
>
> Now you use File::Find::find(), you probably should do this kind of
> trivial filtering inside the callback, no?

I thought about that, but the filter is so simple that it seemed like
overkill to add another function.  If there is another revision of
this patch, I will reconsider.

As always, thanks for the review :)
