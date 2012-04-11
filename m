From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 10/12] completion: add new git_complete helper
Date: Thu, 12 Apr 2012 02:44:19 +0300
Message-ID: <CAMP44s3x0ruqP_N9FH=GKnzXMYtX_kUaLO77YKRGr2GmsA3LHg@mail.gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-11-git-send-email-felipe.contreras@gmail.com>
	<20120411225046.GU2289@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:44:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI7DA-00034V-V2
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 01:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197Ab2DKXoX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 19:44:23 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33874 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965194Ab2DKXoV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 19:44:21 -0400
Received: by eekc41 with SMTP id c41so358669eek.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 16:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=c6hRKd4urz7w2ocThTEO5uCrV3iwjtQ9FoRYNf8CKLU=;
        b=ZlCMAGNEim7inE0wslPvpg3YuEBiIlbW0m90wLkmpy8NR+wZmciZe6rbizQm0wpJaT
         bpXT6bCjJaHbhEIhWzjlBEgDZeVqmrKe6pbXfN5dvf8+Qz+eWbN+rfTLiYXZuxYmKg3b
         I+9eR/Q9+VzSvylgrLBSfUEQoegYETQKsXwgu5t1IydVbDoiVrUafG0qOqCU0Ft/HjoB
         qEv3u31vdnUE6UcVkIkJ10Zawog7qdLqwGlqc3POagJDGAl2gYICQIodqBYoeeACKHfl
         oMzhcCqXgaOFHlyn32JdifkD1MxhFUDqzaDTgCRqFvASI8GKBX/NPb8hI23aPKEKvKxu
         bdQw==
Received: by 10.14.96.3 with SMTP id q3mr39726eef.42.1334187859513; Wed, 11
 Apr 2012 16:44:19 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Wed, 11 Apr 2012 16:44:19 -0700 (PDT)
In-Reply-To: <20120411225046.GU2289@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195282>

2012/4/12 SZEDER G=C3=A1bor <szeder@ira.uka.de>:

>> +{
>> + =C2=A0 =C2=A0 local name=3D"${2-$1}"
>> + =C2=A0 =C2=A0 local cmd=3D"${name#git_}"
>> + =C2=A0 =C2=A0 eval "$(typeset -f foo_wrap | sed -e "s/foo_cmd/$cmd=
/" -e "s/foo/_$name/")"
>> + =C2=A0 =C2=A0 complete -o bashdefault -o default -o nospace -F _${=
name}_wrap $1 2>/dev/null \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || complete -o default -=
o nospace -F _${name}_wrap $1
>> +}
>> +
>> +git_complete git
>> +git_complete gitk
>
> Clever ;)
>
> But it needs a subshell and a sed invocation, so Windows people might
> not be all too happy about this. =C2=A0Perhaps it's not a big deal in=
 the
> default case, because it will be done only twice at startup time.
> However, if someone wants several aliases on Windows, it can cause
> noticeable delay. =C2=A0It's a startup speed vs. convenience trade-of=
f.
> Anyway, I don't have any ideas how those fork()s and exec() could be
> avoided.

Well, if you look at the foo_wrap function you would notice there is
not much 'foo' in it. We could have a __git_wrap () function instead,
but we would need to find an alternative way to set the 'cmd'
variable. The easiest would be to just don't set it at all. As I
suggested, only __git_complete_remote_or_refspec needs it, and can be
easily worked around.

--=20
=46elipe Contreras
