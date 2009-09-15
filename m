From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] Work around leftover temporary save file.
Date: Tue, 15 Sep 2009 15:01:39 +0200
Message-ID: <81b0412b0909150601j74d40181pc2308f4f63b4817e@mail.gmail.com>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
	 <87ab0wcsyp.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexy Borzenkov <snaury@gmail.com>,
	Paul Mackerras <paulus@samba.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Sep 15 15:01:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnXfH-0002O1-Bt
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbZIONBj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 09:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbZIONBi
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:01:38 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:41452 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbZIONBi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 09:01:38 -0400
Received: by bwz19 with SMTP id 19so2763207bwz.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 06:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LLNIEQdgumFsdD7uvb46c+bgrBhXThhuWyBbc1SJekI=;
        b=SgPfGgr/bOGYPSpMfqYzWdRS8nUXxhbQhTeZwuQyh1PgTeupjw22aoSpVRR1UH+Av2
         wZ/9NkQ+kboIZuw2YfWCgddHa7IFSFKVH6ApTSAR7q7kvP45Aob0SyZNMs5sssrdDIiC
         EI0CL47fJ481Dq/aoEiWlCRaVc42+jRY/1rhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LgB+Z3W6K1hy8kte2pY+A4nMvqO05jTWYffaskP4hTyL/UWE4XI2DrIQex5CBDb1m3
         NtF3ZZQKLgmdd/vgrHwDpxq67gNFkvrmNFdciDXIU07mrXOva4fRQPhpBMrYM2Huap5K
         G76MQIO1A64sLHgSYBZJThbP9EQTQtj8QvRSo=
Received: by 10.204.153.27 with SMTP id i27mr6253853bkw.155.1253019700290; 
	Tue, 15 Sep 2009 06:01:40 -0700 (PDT)
In-Reply-To: <87ab0wcsyp.fsf@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128539>

On Tue, Sep 15, 2009 at 11:26, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
>
> If a file exists and is hidden on Windows the Tcl open command will
> fail as the attributes provided in the CREAT call fail to match those
> of the existing file. Forcing removal of the temporary file before we
> begin solves any problems caused by previous failures to save the
> application settings. An alternative would be to remove the hidden
> attribute before calling 'open'.
>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
> =C2=A0gitk | =C2=A0 =C2=A01 +
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/gitk b/gitk
> index 1306178..a0214b7 100755
> --- a/gitk
> +++ b/gitk
> @@ -2526,6 +2526,7 @@ proc savestuff {w} {
> =C2=A0 =C2=A0 if {$stuffsaved} return
> =C2=A0 =C2=A0 if {![winfo viewable .]} return
> =C2=A0 =C2=A0 catch {
> + =C2=A0 =C2=A0 =C2=A0 if {[file exists ~/.gitk-new]} {file delete -f=
orce ~/.gitk-new}

maybe another gitk instance is writing it at exactly same moment
in time? Writing is known to take a few moments. Especially on Windows.
