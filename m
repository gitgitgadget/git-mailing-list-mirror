From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Timestamp of zero in reflog considered invalid
Date: Wed, 6 Apr 2016 14:18:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604061416350.3371@virtualbox>
References: <CAOTD34YpTXperaC0=Sy=21Q9_+0eGO1y-bP-WzrkxFvrDykRXg@mail.gmail.com> <xmqqbn5o2gv1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Erik Bray <erik.m.bray@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 14:19:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anmQr-0003wZ-9O
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 14:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbcDFMTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 08:19:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:49490 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955AbcDFMTb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 08:19:31 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MZ8fw-1b6OhE2GCq-00KzzN; Wed, 06 Apr 2016 14:18:28
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqbn5o2gv1.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:i6d5JmXGs4rj77mrie5xQO9IpLN87/Vh32lSjeuvysOMmtEFoUn
 KEnfM3PX2vPy/XZ9joVZMtGIaV3Px59ZIPAKaxJute7Zd9IboxI82OitE75cDK0Y6Hc5Y2h
 6ci11Xu9fhv9dfAMBsCSWShRp0SfQqKVeUhh8RP6VfdfR0l8fq3ImKHKM1L+4MGjUm0/bz9
 r+2oWs17mIMf0W5Zxu4/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mRcheIueqTg=:0ceZKcM2IL/L4243N13lHu
 pmLCV9jfa3t2LJ52lfQ+RONp0Bek8zAZiUd0mUC42nEOcFU3Rmyf+SNrOZaUiezur6I7J43A0
 JaxEL3SmpoAmwnqh4c/OWzidvJXz8CzhrTciJ+M6oq3GV7g5j7maoFqUZJ6RYCm1Y+2AdvXRv
 Bxh+T/K3aLpyiNEm8I2vSwXSnXUM7Q0PJMjwxoTJTXOI8BztOf7D8zMF/4U6c18ZeObnTgV4T
 cdnfTBxFE56D8Jk6CtDxYzsMS4KANwIgUnit5QOnaJigFERvGOIZdi285fPid/W6wEUtA0qAm
 /Fr3+BhpxI+dphHaGgruvEdaQwkz9FrGh33gvodSvI4hGgLy7bEOu3n9jBag/pof2eW3NkCEr
 U5XgSUYG8P6MqPQoK0EHv5pGHVl7CVQhz+5Dw64RqibaI2+p0H8t5BQHSeSai5bvgNrkqJAwF
 EGKb1P0JZilOfjAioT1rLyaCETbSKu8f61VTgD9phvzVG4IZ1Kwd6L5Y2DBSjXQAqrIhdeaRm
 uNd1KudDyoNqGACmPEosJSBpuhfOWAGCUC01cjb5lYwKC+ui6Oxns31g26kDu7LNiQuwGQ68M
 VyBaf/sZ4/HC5CBqdjLRDD5PJEaUxd36mdrF93M9u2Ii0endxrTvLY1Lu4hr64qOo5hqln0Us
 lbsyfF+rf+gOE4zvGEmlgafqKd3CoBmnwOq8SCUjVShWztd9K+EmRhUqoM/6UMh9CAsiGsKc6
 EeCazu+9FPCPVoCclrqOTPaeOdvYPjijmUTKN21/cMwu/8/wH5jae5Y6C6jVdJ9IswzTtlAi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290838>

Hi Junio,

On Tue, 5 Apr 2016, Junio C Hamano wrote:

> Erik Bray <erik.m.bray@gmail.com> writes:
> 
> > I tracked the issue to refs/files-backend.c in show_one_reflog_ent :
> >
> > https://github.com/git/git/blob/11529ecec914d2f0d7575e6d443c2d5a6ff75424/refs/files-backend.c#L2923
> >
> > in which
> >
> > !(timestamp = strtoul(email_end + 2, &message, 10)) ||
> >
> > implies an invalid reflog entry.  Why should 0 be treated as an
> > invalid timestamp (even if it's unlikely outside of corner cases)?
> 
> Thanks for a report.
> 
> I think this dates back to 883d60fa (Sanitize for_each_reflog_ent(),
> 2007-01-08):

Wow, what a blast from the past.

Unsurprisingly, I do not recall *any* detail about this, but this sounds
like it is the most probable explanation:

> I suspect that there was some confusion as to how strtoul() signals an
> error condition when the commit was written, or something.

FWIW: ACK on the patch:

> diff --git a/refs.c b/refs.c
> index 4e15f60..ff24184 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3701,7 +3701,8 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
>  	    get_sha1_hex(sb->buf + 41, nsha1) || sb->buf[81] != ' ' ||
>  	    !(email_end = strchr(sb->buf + 82, '>')) ||
>  	    email_end[1] != ' ' ||
> -	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
> +	    ((timestamp = strtoul(email_end + 2, &message, 10)) == ULONG_MAX &&
> +	     errno == ERANGE) ||
>  	    !message || message[0] != ' ' ||
>  	    (message[1] != '+' && message[1] != '-') ||
>  	    !isdigit(message[2]) || !isdigit(message[3]) ||

Thanks,
Dscho
