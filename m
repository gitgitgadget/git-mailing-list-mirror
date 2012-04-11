From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] contrib: added git-diffall
Date: Wed, 11 Apr 2012 01:38:21 -0700
Message-ID: <CAJDDKr47BZ=QE_nUqAoFJTRTBUxMHD2QwmqpGYrXb3q1hfyAHA@mail.gmail.com>
References: <1329948749-5908-1-git-send-email-tim.henigan@gmail.com>
	<7vipiy8m5q.fsf@alter.siamese.dyndns.org>
	<CAFouetiSpsZGtLt2tG4ou-H18zigNx5xWQH4cy8GrL1eDxbjJw@mail.gmail.com>
	<loom.20120411T010200-132@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 10:38:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHt4O-0003qK-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 10:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123Ab2DKIiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 04:38:24 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49618 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab2DKIiW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 04:38:22 -0400
Received: by gghe5 with SMTP id e5so312501ggh.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 01:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JuBsU8/eq3nrM9Mo055DWmE5AcMbKnM3rGemh3Qtrck=;
        b=Odas4bFS4gf1ixeM6TwMQkY5VyaLKn/LjLwcKfT5NmnJ9x09QoJ7OmPge2ST0F5GRb
         8X0OmJxYvXX74U8nPEKB0SG+jkYLjoWeB3J1/xWgtZIoJcBL5a452rTiN2vG9tQrJ8A7
         Y1VmcItnhgU2PY5v/fD3U2fqW8p35xr7Pw95Iyx3aWoRd8s5aaX+GK9oUDcHUdnp6jLr
         /WX+5bsYgCIok/d3XAiRTZF2kIn8GjOKp4NGVdFyR2r3D6IomBijDuxDTtIy9VKOWeen
         RTxITOEAliPD4q6wynMzOQwB4zg2M8/Idj/iV9k8woASV15WDin+L0MMBQttCQiKnyZH
         +jpQ==
Received: by 10.236.185.10 with SMTP id t10mr12208758yhm.112.1334133501740;
 Wed, 11 Apr 2012 01:38:21 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Wed, 11 Apr 2012 01:38:21 -0700 (PDT)
In-Reply-To: <loom.20120411T010200-132@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195155>

On Tue, Apr 10, 2012 at 4:06 PM, Matt McClure <matthewlmcclure@gmail.co=
m> wrote:
> Tim Henigan <tim.henigan <at> gmail.com> writes:
>
>> >> + =C2=A0 =C2=A0 do
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp "$file" "$git_top_=
dir/${file#$tmp/$right_dir/}"
>> >> + =C2=A0 =C2=A0 done
>> >> +fi
>> >
>> > This will copy new files created in $right_dir. =C2=A0Is that inte=
nded?
>>
>> hmmm...that was not intended. =C2=A0If would be odd for the user to =
create
>> new files in this tmp directory, but if the diff tool automatically
>> generates any files then this could result in unwanted files.
>
> I think more generally, I would prefer if either side of the comparis=
on is the
> working copy that the temp directory on that side be populated with s=
ymlinks.
>
> A particularly bad failure mode of the copy-back approach is:
>
> git diffall --copy-back
> # while my diffall tool is running, I edit the file somewhere else.
> # quit my diffall tool
> # --> my edits in the other tool are overwritten by diffall
>
> Editing the files in place via symlinks would resolve that.

I had a similar idea but didn't mention it because Windows came to
mind.  I always want to say, "darn it, this code would be so much
easier if we could just ignore Windows", but that's not very helpful.

I'd be happy with a runtime platform check where the copy back is only
done on Windows.  Everyone else can enjoy symlinks.

Reading between the lines that could be interpreted as, "well, that
copy back code is no good and *we* don't want to use it, but it's okay
for Windows users", which is slightly dangerous because we'd always be
running the symlink code path and wouldn't hit problems with the other
path.

So I'm torn.  I think symlinks are a great idea, but Windows drives us
towards the less-than-ideal solution.  I want the best solution
possible.  Do we just accept that the copy-back code is simply the
cost of supporting Windows and keep both code paths around?  I would
not be opposed to that if the result is a more robust user experience.
--=20
David
