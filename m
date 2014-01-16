From: =?UTF-8?B?QmVub8OudCBCb3VyYmnDqQ==?= <benoit.bourbie@gmail.com>
Subject: Re: [PATCH] git-gui: fallback right pane to packed widgets with Tk 8.4
Date: Thu, 16 Jan 2014 10:39:24 -0600
Message-ID: <CANJSc_uhYU7EPZ89dbEQhc8QM4e-yLj2qhQOJMQyzU-2RdZn8A@mail.gmail.com>
References: <CANJSc_uYm7f4LoZoMoVzcsmGrYnUy+2nXFL_cNWqQnwLb5J6mw@mail.gmail.com>
 <20140114011141.GF18964@google.com> <20140114065014.GA29816@wheezy.local> <20140114235809.GA15510@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Jan 16 17:39:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3pyv-0007wH-Uf
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 17:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbaAPQjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jan 2014 11:39:46 -0500
Received: from mail-we0-f180.google.com ([74.125.82.180]:46724 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbaAPQjp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 11:39:45 -0500
Received: by mail-we0-f180.google.com with SMTP id q59so3386688wes.25
        for <git@vger.kernel.org>; Thu, 16 Jan 2014 08:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=eZdzgxVF+KkhZ94PeKh5CQ+Oi65TQTjkr976uliEiCc=;
        b=Ao12RGurrB4NOHNsQq0CLXKdhAx0PC3EOQTdt0F0fzPpLcHPv5c4u17ZFraXTwxD0k
         CoQ1LKy9AkAn43gKvIQgaTce48Vb3zNF0QNyvRRoad6ql3XBPZ1hHywCHvAvsOMcawXR
         uhxPg/N9pme3HeLdm9sFLBedPHmPBWf9VqYYXJHlEwsl30i4gJtdHmCRq5UXNiwJJgyf
         pXYo7iIqhNC0IpOvLPJo/ho656jMSeyq51ur0kWAN5biKqalx2iKN6ud4OIzYhhzSKtq
         5OMh0HUpxEpJLkxl0dAAnB3hPtd3WRtHU0A2NGFY87zSvDakoiAGmwNLWF+pYNF7bSGj
         ySHQ==
X-Received: by 10.180.211.39 with SMTP id mz7mr8925014wic.53.1389890384157;
 Thu, 16 Jan 2014 08:39:44 -0800 (PST)
Received: by 10.194.28.3 with HTTP; Thu, 16 Jan 2014 08:39:24 -0800 (PST)
In-Reply-To: <20140114235809.GA15510@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240516>

Hi All,

Max, you are right, my TK version is 8.4.
I applied the patch and it now works perfectly.

Thanks!!

Beno=C3=AEt

On Tue, Jan 14, 2014 at 5:58 PM, Max Kirillov <max@max630.net> wrote:
> Since 918dbf58, git-gui crashes if started with Tk 8.4. The reason is=
 that
> tk < 8.5 does not support -stretch option for panedwindow.
>
> Without the option it's not possible to properly expand the right hal=
f -
> the commit area is expanded, while desired behavior is to expand the =
diff
> area. So the whole feature should be disabled with Tk
> version less than 8.5.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  git-gui/git-gui.sh | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index e2e710e..147be8c 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -3196,18 +3196,28 @@ unset i
>
>  # -- Diff and Commit Area
>  #
> -${NS}::panedwindow .vpane.lower -orient vertical
> -${NS}::frame .vpane.lower.commarea
> -${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1 -height=
 500
> -.vpane.lower add .vpane.lower.diff
> -.vpane.lower add .vpane.lower.commarea
> -.vpane add .vpane.lower
> -if {$use_ttk} {
> -       .vpane.lower pane .vpane.lower.diff -weight 1
> -       .vpane.lower pane .vpane.lower.commarea -weight 0
> +if {$have_tk85} {
> +       ${NS}::panedwindow .vpane.lower -orient vertical
> +       ${NS}::frame .vpane.lower.commarea
> +       ${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1 =
-height 500
> +       .vpane.lower add .vpane.lower.diff
> +       .vpane.lower add .vpane.lower.commarea
> +       .vpane add .vpane.lower
> +       if {$use_ttk} {
> +               .vpane.lower pane .vpane.lower.diff -weight 1
> +               .vpane.lower pane .vpane.lower.commarea -weight 0
> +       } else {
> +               .vpane.lower paneconfigure .vpane.lower.diff -stretch=
 always
> +               .vpane.lower paneconfigure .vpane.lower.commarea -str=
etch never
> +       }
>  } else {
> -       .vpane.lower paneconfigure .vpane.lower.diff -stretch always
> -       .vpane.lower paneconfigure .vpane.lower.commarea -stretch nev=
er
> +       frame .vpane.lower -height 300 -width 400
> +       frame .vpane.lower.commarea
> +       frame .vpane.lower.diff -relief sunken -borderwidth 1
> +       pack .vpane.lower.diff -fill both -expand 1
> +       pack .vpane.lower.commarea -side bottom -fill x
> +       .vpane add .vpane.lower
> +       .vpane paneconfigure .vpane.lower -sticky nsew
>  }
>
>  # -- Commit Area Buttons
> --
> 1.8.4.2.1566.g3c1a064
