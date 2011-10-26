From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/WIP 02/11] notes-merge: use opendir/readdir instead of
 using read_directory()
Date: Wed, 26 Oct 2011 11:08:55 +1100
Message-ID: <CACsJy8CocoAiVx_PeaaX1oRZvmzfj9-z9JLJkE5unSRVtpGkNA@mail.gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-3-git-send-email-pclouds@gmail.com> <7vzkgo3m9b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 26 02:09:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIr3k-0003qr-PA
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 02:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936Ab1JZAJ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 20:09:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39289 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab1JZAJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 20:09:26 -0400
Received: by bkbzt19 with SMTP id zt19so1090158bkb.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 17:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=liaaWhNAlH5cTmh9VTiHO071NhdTP24L1D0oa02OgNU=;
        b=NO/dz2PTaoHfTStnGIvld6Qocecmr3csRfzjMpWq//+V0LRS1zkIBZTv9Zr2SWjeSh
         KrZ10jwa0c53/Mkuu2WdFd61KsSZp9Qm5BfXO1tetHwTaHzmLyaUo3TWld4O4DrBCvuh
         gAsjwC/MrVML6FxFWlWaEpR81zEuLVO63kRcE=
Received: by 10.204.9.205 with SMTP id m13mr13347864bkm.32.1319587765205; Tue,
 25 Oct 2011 17:09:25 -0700 (PDT)
Received: by 10.204.114.2 with HTTP; Tue, 25 Oct 2011 17:08:55 -0700 (PDT)
In-Reply-To: <7vzkgo3m9b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184242>

2011/10/26 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> notes_merge_commit() only needs to list all entries (non-recursively=
)
>> under a directory, which can be easily accomplished with
>> opendir/readdir and would be more lightweight than read_directory().
>>
>> read_directory() is designed to list paths inside a working
>> directory. Using it outside of its scope may lead to undesired effec=
ts.
>
> Technically isn't the directory structure this codepath looks at a wo=
rking
> tree that has extract of a notes tree commit?

Yes it's like a secondary working tree, only for notes, if I read the
code correctly. The thing is this space is inside ".git".

Current read_directory() treats given path separately from contents
inside the path. If the given path has ".git", it's ok (but it'll stop
at .git if during tree recursion). The new read_directory() does not
make this exception, so when note-merge call
read_directory(".git/NOTES_MERGE_WORKTREE"), read_directory() sees
".git" and stops immediately, assuming it's a gitlink.

One could say we should keep current behavior, but I don't really see
it's worth the effort.
--=20
Duy
