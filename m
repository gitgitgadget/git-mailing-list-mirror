From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: fix selection regression introduced in a8ca786991
Date: Sat, 14 Jan 2012 12:58:47 +0100
Message-ID: <CAKPyHN31MV7PcSNP+ovdXx2H7Lbu=hxMN_pPOfi1TZW1qnYRvQ@mail.gmail.com>
References: <14628854a651ab0202e3f82be9b245331cf9029a.1325965254.git.bert.wesarg@googlemail.com>
	<CAKPyHN0xRD7qYyLYaCB9u7mhCZYFObuTdJGHq-rRST-cEhTtXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Jan 14 12:58:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm2G9-0003s1-BU
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 12:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088Ab2ANL6v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 06:58:51 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:60751 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2ANL6u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2012 06:58:50 -0500
Received: by werb13 with SMTP id b13so993847wer.19
        for <git@vger.kernel.org>; Sat, 14 Jan 2012 03:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5Hm82z2ZdNBde8RwHwRlAt6N1flzAu6RW3qvUdpa/6I=;
        b=YTcXxXAVRifmlnCyTczWNrunuNNoMuHievGoyEebnLsoDYylXf5Y0c86MQjDlm/fmE
         om/qzyRWcaLmAovPzzwKedCc0RKPpqrncR53FiNBgmIxn9larDp74Xe7lpgQBe7MoP5S
         yuMVRswP+dXKKNDLEjKL5YfVXWjo5+0cBdLRs=
Received: by 10.216.131.78 with SMTP id l56mr389404wei.56.1326542327683; Sat,
 14 Jan 2012 03:58:47 -0800 (PST)
Received: by 10.223.118.10 with HTTP; Sat, 14 Jan 2012 03:58:47 -0800 (PST)
In-Reply-To: <CAKPyHN0xRD7qYyLYaCB9u7mhCZYFObuTdJGHq-rRST-cEhTtXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188561>

Hi Pat,

On Mon, Jan 9, 2012 at 10:28, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> Hi,
>
> On Sat, Jan 7, 2012 at 20:43, Bert Wesarg <bert.wesarg@googlemail.com=
> wrote:
>> While fixing the problem from a8ca786991, it introduces a regression
>> regarding what happen after the multi selected file operation (ie.
>> one of Ctrl-{T,U,J}) because the next selected file could not be han=
dled
>> by such a subsequent file operation.
>>
>> The right way is to move the fix from this commit down into the show=
_diff
>> function. So that all code path add the current diff path to the lis=
t of
>> selections.
>>
>> This also simplifies helper functions for these operatione which nee=
ded
>> to handle the case whether there is only the current diff path or al=
so
>> a selction.
>
> I think we need to think this more through, especially with input fro=
m
> Shawn, please.
>
> I have now find out, that git-gui has two selections in the file
> lists. The first is that for the current path for what we show the
> diff (the tag for this is called 'in_diff') and the the second is tha=
t
> for the current list of paths which are selected ('in_sel'). The file
> list operations 'staging', 'reverting', 'unstaging', work either on
> 'in_sel'; if that is not empty, or on 'in_diff'. The problem I've now
> realized is, that these two selections share the same visual hints,
> ie. a lightgray background.
>
> The problem I tried to solve in a8ca786991 was, that adding paths to
> the selection with Ctrl-Button-1 or Shift-cutton-1, didn't included
> the current diff path in the subsequent file list operation. But I
> would have expected it, because it was visual in the 'selection'.
>
> My current 'workaround' is to make the two selections visually
> distinguishable (and reverting a8ca786991), by using a different
> background color for the 'in_sel' tag and also the italic font, so
> that it is still possible to see whether the current diff path is in
> the selection or not:
>
> @@ -717,11 +717,11 @@ proc tk_optionMenu {w varName args} {
> =C2=A0proc rmsel_tag {text} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$text tag conf sel \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-background [$=
text cget -background] \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-foreground [$=
text cget -foreground] \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-borderwidth 0
> - =C2=A0 =C2=A0 =C2=A0 $text tag conf in_sel -background lightgray
> + =C2=A0 =C2=A0 =C2=A0 $text tag conf in_sel -background SlateGray1 -=
font font_diffitalic
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bind $text <Motion> break
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return $text
> =C2=A0}
>
> =C2=A0wm withdraw .
> @@ -3557,11 +3557,11 @@ if {$use_ttk} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.vpane.files add .vpane.files.index -stick=
y news
> =C2=A0}
>
> =C2=A0foreach i [list $ui_index $ui_workdir] {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rmsel_tag $i
> - =C2=A0 =C2=A0 =C2=A0 $i tag conf in_diff -background [$i tag cget i=
n_sel -background]
> + =C2=A0 =C2=A0 =C2=A0 $i tag conf in_diff -background lightgray
> =C2=A0}
> =C2=A0unset i
>
> =C2=A0set files_ctxm .vpane.files.ctxm
> =C2=A0menu $files_ctxm -tearoff 0
>
> I'm not very pleased with this, but at least it is now possible to
> visual recognize what files will be handled by a subsequent file list
> operation.
>
> Any input is more than welcome.
>

I think we don't resolve this now, because a8ca786991 introduced a
regression introduced in 0.16, I propose to revert it for upcoming
1.7.9 release.

Thanks.

Bert

> Regards,
> Bert
