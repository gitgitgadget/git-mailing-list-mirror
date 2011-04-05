From: Alif Wahid <alif.wahid@gmail.com>
Subject: Re: Git exhausts memory.
Date: Tue, 5 Apr 2011 21:26:03 +1000
Message-ID: <BANLkTi=cBcsu1uehkLUP8-io9r1j-=jmNg@mail.gmail.com>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
	<alpine.LFD.2.00.1104021103130.28032@xanadu.home>
	<BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
	<alpine.LFD.2.00.1104031110150.28032@xanadu.home>
	<BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
	<BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com>
	<20110405022235.GA4414@spacedout.fries.net>
	<BANLkTik6XoWaehp7=5fxwcyhkTHWCO8-Eg@mail.gmail.com>
	<BANLkTi=nzY7wFTr3647SYkSMHx=AityRgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Fries <david@fries.net>, Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 13:26:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q74Oh-0007N2-3W
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 13:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab1DEL0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 07:26:05 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61314 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab1DEL0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 07:26:04 -0400
Received: by vws1 with SMTP id 1so160071vws.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 04:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4azapvpiruxnbh5+giez1nMPy/8aH9XttFRsh4rVDrs=;
        b=gYOLlhiSukJ1tTABPUZpHNcMaBqBBDrr3+QS6EOhj1HxOa2K/wQD2Dc+ZkL7+BDI4c
         3K646Jq7eHnmjWhpKVtqKcKRULdafgUi20skVtUeF2uN+FX1WjcP9GLsdlGE+EUq6GPB
         jqPY4R1/rCX3GbdxfdKPAcpJJAWZJB8RSWuJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=f0b8lxpFut1FiiCUYaqHn5MUDBg5mioqtbkKN5e6juxzc/45BqmH/9Fc7/zmHUqQXT
         tpR+M7t06SzgWZUWfOyq/FOhF05KVeuiLf6JzMsyoES+CxODCy/H8G5rIolna0vmXw7W
         Wwt9oV5phFMddeoyKCKWgxHIwJlWoT+7EHbjQ=
Received: by 10.52.168.8 with SMTP id zs8mr1475691vdb.184.1302002763358; Tue,
 05 Apr 2011 04:26:03 -0700 (PDT)
Received: by 10.52.155.70 with HTTP; Tue, 5 Apr 2011 04:26:03 -0700 (PDT)
In-Reply-To: <BANLkTi=nzY7wFTr3647SYkSMHx=AityRgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170879>

On 5 April 2011 21:13, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Tue, Apr 5, 2011 at 11:35 AM, Alif Wahid <alif.wahid@gmail.com> wrote:
>> It seems to me that if "git init" creates a $GIT_DIR/info/attributes
>> file by default with a line like "*.gz -delta", then that will disable
>> the memory intensive deltra compression plumbing for those special
>> cases where people need to track gzip archives (similarly another line
>> "*.bz2 -delta" for bzip2 archives and so on). Since these files can't
>> supposedly be compressed much more, I think Git ought to have a
>> default heuristic to not attempt any compression on them.
>
> I was thinking of very similar thing on my ride home. But I selected
> files on size, not extension. With the (hopefully coming soon)
> introduction of pathspec magic specifier [1], we can teach git-attr to
> express "files that have size in a range [a,b]" (either a or b can be
> infinite). The rest is like yours: applying -delta on selected files
> then put such a rule with a default range in default template.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/169813/focus=169844

Yeah, makes sense.

I also noticed the following thread regarding big file support. Most
of the details there are related to this issue as well.

http://thread.gmane.org/gmane.comp.version-control.git/170649/focus=170649

Alif
