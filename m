From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/9] difftool: parse options using Getopt::Long
Date: Sat, 17 Mar 2012 20:29:45 -0700
Message-ID: <CAJDDKr5bvNK2Pd+-wbTNgZdui91-zs_qST3PWKnHVmp-vGYVqg@mail.gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
	<1331949442-15039-2-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7BTz-2THw1JaJEDcK1G4Uxwc88=gFsHCSONHAtqtypRw@mail.gmail.com>
	<CAFouetgpz__1q7F_a3LQoeypCVBXOyTPWmL0e9=rw7vV65d7_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 04:30:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S96p0-0003N0-Hu
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 04:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab2CRD35 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 23:29:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59779 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750Ab2CRD3q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 23:29:46 -0400
Received: by gghe5 with SMTP id e5so5005265ggh.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 20:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xg/Clm1c5+mzVJ6EFyeZJDsCZYC4F44Nn3GXwhBh2xY=;
        b=l9R1L2E83JpgQSIX61+U1zKVp8p8r8kFNCZebFee8WsouCbtwNtBZhGAg4E5QAhAF4
         nKuDmlDcqT+9yH9z6kFD/79DYxbj/LHonOz8JbpsOzMcbIBmgO02AyWWoOesMj/8XZRD
         yL7baCgHK8RAojzu/eWzGgKBFy0kYZg+aCtJlA/U2RvgABjT1kce7JuWrjPbIZj/H+Jh
         bACk5YcyBUcpGBsbwkt94hQK2jS90hCh7RBK/LkGyHqbu2T+q23gPejk079hkFElWKFn
         ArRGRVco6qs23PbgqUJwl7gX9zp4c+I/Dce4HZ/XatTuJDVC7kLlp/jFkic9qfFNpJ5Q
         Tw7Q==
Received: by 10.101.137.19 with SMTP id p19mr2571196ann.87.1332041385969; Sat,
 17 Mar 2012 20:29:45 -0700 (PDT)
Received: by 10.147.143.4 with HTTP; Sat, 17 Mar 2012 20:29:45 -0700 (PDT)
In-Reply-To: <CAFouetgpz__1q7F_a3LQoeypCVBXOyTPWmL0e9=rw7vV65d7_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193367>

On Sat, Mar 17, 2012 at 6:54 AM, Tim Henigan <tim.henigan@gmail.com> wr=
ote:
> On Fri, Mar 16, 2012 at 11:21 PM, David Aguilar <davvid@gmail.com> wr=
ote:
>> On Fri, Mar 16, 2012 at 6:57 PM, Tim Henigan <tim.henigan@gmail.com>=
 wrote:
>>
>> I've also wanted to do the same in the past. =C2=A0The one thing hol=
ding me
>> back was this note from the perldocs:
>>
>> "If pass_through is also enabled, options processing will terminate =
at
>> the first unrecognized option, or non-option, whichever comes first.=
"
>>
>> http://search.cpan.org/~jv/Getopt-Long-2.38/lib/Getopt/Long.pm
>
> That sentence is listed under the documentation of the 'permute'
> option. =C2=A0The documentation of 'pass_through' states that:
>
> "Options that are unknown, ambiguous or supplied with an invalid
> option value are passed through in @ARGV instead of being flagged as
> errors. This makes it possible to write wrapper scripts that process
> only part of the user supplied command line arguments, and pass the
> remaining options to some other program.
>
> If require_order is enabled, options processing will terminate at the
> first unrecognized option, or non-option, whichever comes first.
> However, if permute is enabled instead, results can become confusing.=
"
>
> So early termination would only be a problem if 'pass_through' was
> enabled at the same time as 'require_order' or 'permute'. =C2=A0To ve=
rify,
> I confirmed that 'git difftool --cached --diff-dir' works as expected=
=2E
>
>
>> Is this indeed the case? =C2=A0I am a little ashamed that the diffto=
ol
>> tests do not cover this area. =C2=A0That would be a valuable first s=
tep
>> towards exploring this approach, IMO.
>
> I will review the the test cases. =C2=A0If this goes forward, I still=
 need
> to add test cases to confirm the new '--dir-diff' option.
>
>
>> BTW, I hate @ARGV parsing loops just as much as anyone! =C2=A0I was =
not
>> ignorant of Getopt::Long, and no, I was not re-inventing the wheel f=
or
>> no reason. =C2=A0The reason it was done that way was so that we can =
forward
>> everything we don't know about to git-diff.
>
> I understand and was not implying anything different. =C2=A0I simply
> thought this would be a positive change.

Hehehe, well apparently I was ignorant about the permute_order and
pass_through interaction afterall ;-)  Thanks for the careful reading
of the docs.  I should have done that sooner.

I highly appreciate your rework of this stuff -- this cleanup is quite
nice.  ++Getopt::Long.

I sent a patch testing the "forward options to diff" behavior sometime
yesterday(?) so we should be good on that side.  Testing the diff-diff
stuff will be good.

Thanks a lot for this, it's a sweet feature and I know the users I
help will get a lot of mileage out of it.
--=20
David
