From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 (for maint)] git-completion: fix zsh support
Date: Mon, 9 May 2011 21:04:21 -0500
Message-ID: <20110510020421.GA25814@elie>
References: <1304973913-5376-1-git-send-email-felipe.contreras@gmail.com>
 <20110509211316.GB22908@elie>
 <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 04:04:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJcJM-0003YT-LI
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 04:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab1EJCE2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 22:04:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64606 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab1EJCE1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 22:04:27 -0400
Received: by iyb14 with SMTP id 14so4805024iyb.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 19:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5bprdzsepzh1FE8IM0sd4NFg/qiWDCwksM9Qep/Wzkc=;
        b=iJNYinilYwjsXiHBAHqa7Gb86G4U2emZsC0C/W4EmeAUHp8OsyfU9i+h26dxErHMFH
         hJGX2+jUF+s1lfwR78UXeZjtA63tC2lWpr8szKAzUxPUBkAEnRK6Ga7DfUgCAPYaT+EL
         L1rvrsbtzvACbD/LpTfUjz93Ku3ReOjNiil+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=R7Cmu15nZFGc2HAG0hbTr5zpWb31QhfgFwP3lQ8+Gm1ASr1k6hm9RPKz+oYD9STu6A
         7X+7OJzF3AuaqMwgHDN72iju0Fff+dh77qHJG834fptyFvls9rW6Qsgs+iAJm9GiNNYO
         gjWzz9ccIHMmbfXWv0w4QiincqPcJvb0n4la4=
Received: by 10.42.1.82 with SMTP id 18mr3479223icf.274.1304993066984;
        Mon, 09 May 2011 19:04:26 -0700 (PDT)
Received: from elie (wireless-165-232.uchicago.edu [128.135.165.232])
        by mx.google.com with ESMTPS id 14sm2881127ibc.8.2011.05.09.19.04.24
        (version=SSLv3 cipher=OTHER);
        Mon, 09 May 2011 19:04:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173298>

Hi,

Sorry I missed this message before.

=46elipe Contreras wrote:
> On Tue, May 10, 2011 at 12:13 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0zsh's bash completion emulation layer doe=
s not sufficiently
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0insulate us from that reality. =C2=A0In p=
articular, the variable
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0keeps the "special" attribute (even after=
 a declaration "local
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0words"), so assignments within a function=
 are undone whenever
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the function returns.
>
> That explains less.

I believe you.  Could you give a hint of what it misses, so that it
can be fixed?

What I was trying to say is that (in the previous paragraph) it turns
out 'words' is a special variable used by zsh completion and (in the
quoted text)

 - we would prefer to use that variable for something else

 - zsh's bashcompinit library can and should help us to do so

 - it would do so by using typeset -h to hide the variable, an
   important effect of which is to clear the attribute called
   "special"

 - even declaring "local words" does not clear that attribute

 - the pertinent effect here is that (in the words of the zshcompwid
   manpage) as long as parameters like words remain special, "except
   for compstate, the parameters are reset on each function exit
   (including nested function calls from within the completion widget)
   to the values they had when the function was entered".

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0In particular, until 3bee6a473 (completio=
n: don't declare
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0'local words' to make zsh happy, 2011-04-=
28), the "words" array
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0would be cleared in _git by declaring "lo=
cal words" and its new
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0value would never be propagated from _get=
_comp_words_by_ref so
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0it remained empty and the completion scri=
pt could not tell that
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0there were existing subcommand names on t=
he command line (so
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"git log m<TAB>" would complete subcomman=
d names).
>
> I don't see the point in explaining in excruciating detail all the
> series of steps in which an unset variable causes problems; the
> variable doesn't get set, thus one can assume there are problems.

Am I daft?  I guess so.  I really do have sympathy for the person who
runs into this code, and wanting to check while making some change
with unrelated purpose that it is still fixed, fires up zsh and runs

	git a<TAB>

=2E  Does it complete?  Yep, check, moving on.  Oops.

There's some flamebait in the rest of your responses, so I'm snipping
the rest of my explanations.  If you have sincere questions about my
feedback in the future, I'd be glad to answer them.
