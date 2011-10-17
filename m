From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 3/3] git-gui: new config to control staging of untracked files
Date: Mon, 17 Oct 2011 20:47:50 +0200
Message-ID: <CAKPyHN3pKUSLTs8_5QMo5i+=3w7KXAHJjDOfQ1XYG92ZbQ1SeA@mail.gmail.com>
References: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
	<03727ea04f20c953e7de3f84ab1724a8360ca2c4.1318620267.git.bert.wesarg@googlemail.com>
	<20111017183430.GA2540@sandbox-rc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Oct 17 20:47:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFsE7-00007d-Qz
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 20:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652Ab1JQSrv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Oct 2011 14:47:51 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59172 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab1JQSrv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 14:47:51 -0400
Received: by vws1 with SMTP id 1so2844739vws.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=v2NwQICXXrvX/ZLCt1HKjfidm54F+/omG5yUI7I9uWo=;
        b=bAD5/h+oyNjlL+qPHIcB8XynoVUkwgZ0idAWP4y3PwCcEXilhgN6BRULcX/iwSp4oo
         SQbd/8qFm0RE9dh0/Ob2/g6f46110KoxMfd799aNbTV0d0llk1H1hiTKC01exwVJ0Z8l
         l2kZSIPYt99sry4NrdGlDlcAsHnPTZoMEfJ0k=
Received: by 10.52.92.212 with SMTP id co20mr21799208vdb.119.1318877270144;
 Mon, 17 Oct 2011 11:47:50 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Mon, 17 Oct 2011 11:47:50 -0700 (PDT)
In-Reply-To: <20111017183430.GA2540@sandbox-rc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183806>

On Mon, Oct 17, 2011 at 20:34, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Hi,
>
> what the series tries to achieve looks good to me. Just one comment.

Thanks.

>
> On Fri, Oct 14, 2011 at 09:25:21PM +0200, Bert Wesarg wrote:
> [...]
>> diff --git a/lib/index.tcl b/lib/index.tcl
>> index 014acf9..45094c2 100644
>> --- a/lib/index.tcl
>> +++ b/lib/index.tcl
>> @@ -367,7 +367,19 @@ proc do_add_all {} {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 if {[llength $untracked_paths]} {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set reply [ask_popup [mc=
 "Stage also untracked files?"]]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set reply 0
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch -- [get_config gu=
i.stageuntracked] {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 set reply 0
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> [...]
>
> Here I am wondering whether we have a similar mechanism in git gui li=
ke
> in core git that makes yes,true,1 equivalents (and similar with other
> values) ?

But it is not only yes,true,1 or no,false,0 its a tristate with the
third state 'ask'. For booleans, there is such functionality in git
gui. See is_config_true and is_config_false. Reusing these for this
tristate wouldn't work. The current check here is indeed very strict
and should be loosen by at least ignoring the case, surrounding
spaces, and allow also true/false. But also note, that this variable
can be set via the Options menu, so you can't mistype it.

Bert

> If we don't I think the series is fine as it is otherwise it
> probably makes sense to use that mechanism.
>
> Cheers Heiko
>
