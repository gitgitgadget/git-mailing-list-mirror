From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: Fast staging/unstaging of hunks/lines
Date: Sun, 11 Apr 2010 09:38:51 +0200
Message-ID: <x2o36ca99e91004110038oce1ffa15jc49244f228ce218@mail.gmail.com>
References: <7ed246d74b2ea872a4af3b99d519590ab17ffefc.1270457921.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 09:39:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0rkw-00070I-39
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 09:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab0DKHix convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 03:38:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:59544 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab0DKHiw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 03:38:52 -0400
Received: by fg-out-1718.google.com with SMTP id 22so221381fge.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 00:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HRWFJK6pY0qVWm60feMEl1YQmzm/UlZDWQjDWKO6t00=;
        b=iCtaGCTv30Xhk+qudp18DAS4lTpoNZBroGcdXGk4ITQDllEgoUltEuRM2uW9yf/Ytg
         pEIDSdmIAF1dni9mIrCHtemF1idb6zzp11R+xkwQI5bDVEE96la1y3rYN9DWGiJWbQdK
         GZ0VtEvYgBGZ7+pQvGq4t/TBawo3RL+FZMiaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qOVHduMWis49HR7ykqf3tRbVCfk6OW5EK3iBnUgJua7Hr+ODPO7rwVZ+MDbfQslbbE
         B0/iFsvZABUiyKh2wqvhDYoRfhPqId1uq/mIBfAR5peYdUXpZrmYkrU0S/ZUvIgxiU5v
         dbulkWjZwgGOQLDuM1QgROWg+Uxdy0W4CRzWQ=
Received: by 10.223.111.7 with HTTP; Sun, 11 Apr 2010 00:38:51 -0700 (PDT)
In-Reply-To: <7ed246d74b2ea872a4af3b99d519590ab17ffefc.1270457921.git.bert.wesarg@googlemail.com>
Received: by 10.223.64.194 with SMTP id f2mr1908086fai.2.1270971531143; Sun, 
	11 Apr 2010 00:38:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144632>

On Mon, Apr 5, 2010 at 11:01, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> This adds a shortcut to stage/unstage hunks or a range of lines. Whic=
h is done
> on a mouse button 1 release event and holding the control key in the =
diff view.
> If there is currently a selection only the selected lines will be sta=
ged/unstaged.
> Otherwise the hunk will be staged/unstaged.

Ping.

>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
> =C2=A0git-gui/git-gui.sh | =C2=A0 16 ++++++++++++++++
> =C2=A01 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 7d54511..e65a0e6 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -3452,6 +3452,22 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X=
 Y} {
> =C2=A0}
> =C2=A0bind_button3 $ui_diff [list popup_diff_menu $ctxm $ctxmmg $ctxm=
sm %x %y %X %Y]
>
> +# applies/reverses hunks or lines on button-1 release
> +proc immediate_apply_hunk_or_lines {x y} {
> + =C2=A0 =C2=A0 =C2=A0 global current_diff_path file_states
> + =C2=A0 =C2=A0 =C2=A0 set ::cursorX $x
> + =C2=A0 =C2=A0 =C2=A0 set ::cursorY $y
> +
> + =C2=A0 =C2=A0 =C2=A0 set has_range [expr {[$::ui_diff tag nextrange=
 sel 0.0] !=3D {}}]
> + =C2=A0 =C2=A0 =C2=A0 if {$has_range} {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apply_range_or_lin=
e $::cursorX $:cursorY
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_rescan
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apply_hunk $::curs=
orX $::cursorY
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +bind $ui_diff <$M1B-ButtonRelease-1> {immediate_apply_hunk_or_lines =
%x %y}
> +
> =C2=A0# -- Status Bar
> =C2=A0#
> =C2=A0set main_status [::status_bar::new .status]
> --
> 1.7.0.3.418.gf56ac.dirty
>
>
