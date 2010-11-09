From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] checkout: do not switch branch during a rebase unless -f
 is given
Date: Tue, 9 Nov 2010 21:15:02 +0700
Message-ID: <AANLkTi=VtP=T7PwY-PcZ9sHy0FjU8Nj=Fe1eWc44Q+OE@mail.gmail.com>
References: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
 <1285649702-24773-1-git-send-email-pclouds@gmail.com> <AANLkTinUudOXmhKW-+rkcpzb-VNnSBLZwGZcjrS6UdMu@mail.gmail.com>
 <AANLkTin19PREB3B68s+ejsgtXwe3CBxZF-caCvRp4UXv@mail.gmail.com>
 <AANLkTinKNF6OEX=k1aepD-Zrm2_4GzHaB+SVHdfTMG-j@mail.gmail.com> <20101109140615.GA18960@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 15:15:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFoyw-0007JN-HT
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 15:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab0KIOPZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 09:15:25 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59056 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab0KIOPY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 09:15:24 -0500
Received: by eye27 with SMTP id 27so3504683eye.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 06:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1mOLJkOXwP35Jv4Gar4JLPBI6vghCAWw81xVRhE38F8=;
        b=NU9bhF6VDLy/lvKw5I4mrbe2o+BvMOz6qrWcRNkBGZ9YVzWXTvJFxnsO7S+ln5Ecy2
         gGnTOTx3WGDEUUj2sg3AQuHZX2SE8ki8v65c6vXd1tWLc2s9iSNW/sXo8ssWKVqOdGZR
         95s8dGaP+Ig9OMlMlfvRE5YO6sTP6l37UWQpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Z3Zgv7EOYXLE9kITO+IuyAKhdjj9mBXI2TvI8Pofod90Kd6ZvIL4lC1MmMtSzSd1a+
         pCzOcLsF5tScfxKsXDFzXStLndUSOSy3p+yknLlasSR9O58hbjnOAmXvXu9YhDXlVbiP
         BZrzfRVRkWEqxjgXG3W5aRRCNk47pDZPcKW9w=
Received: by 10.216.47.19 with SMTP id s19mr849115web.56.1289312123145; Tue,
 09 Nov 2010 06:15:23 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Tue, 9 Nov 2010 06:15:02 -0800 (PST)
In-Reply-To: <20101109140615.GA18960@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161050>

2010/11/9 Jonathan Nieder <jrnieder@gmail.com>:
> Nguyen Thai Ngoc Duy wrote:
>
>> Another approach is to let checkout work as usual, but refuse update=
 refs:
>>
>> =C2=A0- after rebase starts, HEAD can only be updated either by reba=
se, or
>> any commands that keep HEAD a headless ref.
>> =C2=A0- the branch being rebased is locked. No commands but rebase c=
an update it.
>>
>> I think the second point is good for all interactive commands like
>> rebase. Create a .lock file with a signature inside (e.g. command
>> name). If update_ref() callers do not give correct signature, refuse
>> to update.
>
> I like it. =C2=A0Would it be possible to make sure the (widespread?) =
practice
> of using
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -fr .git/rebase-merge
>
> to terminate a rebase without going back to the original branch
> still works? =C2=A0I think it should be.
>

I don't know. If we can place the branch lock inside
=2Egit/rebase-merge, then yes removing that directory will also remove
the lock. But how does git find the locks if they are everywhere in
=2Egit?
--=20
Duy
