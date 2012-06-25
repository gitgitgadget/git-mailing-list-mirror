From: Phil Hord <phil.hord@gmail.com>
Subject: Re: MERGE_RR droppings
Date: Mon, 25 Jun 2012 14:36:39 -0400
Message-ID: <CABURp0rBRnFjJaXO3BUYWcyXEAsLZeEv05z-hMi8aW9SPTCPqA@mail.gmail.com>
References: <CABURp0omkVoLrz29GeOjjoZOpN238Rm6Nu5aOKQyVxFVnPihsw@mail.gmail.com>
 <CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com> <7v8vfk2pby.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davvid@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 20:37:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjE9r-0001rV-Ny
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 20:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761Ab2FYShB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 14:37:01 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40576 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750Ab2FYShA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 14:37:00 -0400
Received: by obbuo13 with SMTP id uo13so6806969obb.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WWseHaN6hisC3Z6GI9qVEjXdGj8RwIbfOfzl0m/rsYU=;
        b=BVShw2W2KaEz7oM97qDzBWNtU7BlRiJDL+x93Xrl3QUEW6DHvAEbIMYj9sdaui98jF
         t/LbZj5D5omn171K/9fgfdviVDzvzaPX3AzzHNjHALtVmbkIg+avceEICj2lAbt4KWbq
         X33ESbompDDme1fGPzQJC8doTPI7UxTJEY/xpMzcIuPKbMk5OR20Bc2PXVezREM7ugUh
         CSH9d7Cbp8ITv9BBxOEkF0nKBk3gGSHT9Yd3bayYFqio6ML9rlMyVHF8GeAuzj/6FElB
         Zs7UC8OhUngicCfjoNKXUe0B/uJaUo/UlmsDw5nFbd8me2YH23l8CMGekBURAKC9IBNd
         qxag==
Received: by 10.182.50.103 with SMTP id b7mr13066326obo.15.1340649419936; Mon,
 25 Jun 2012 11:36:59 -0700 (PDT)
Received: by 10.182.111.99 with HTTP; Mon, 25 Jun 2012 11:36:39 -0700 (PDT)
In-Reply-To: <7v8vfk2pby.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200590>

On Mon, Jun 18, 2012 at 7:05 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> git mergetool decides to use rerere-remaining based on the existence
>> of the .git/MERGE_RR file:
>>
>> =A0 =A0 if test -e "$GIT_DIR/MERGE_RR"
>
> This is correct, I would probably write it with "test -f" if I were
> writing this line today, though. =A0After you commit to conclude the
> merge, the MERGE_RR marker should disappear. =A0Isn't it happening fo=
r
> you?

I was able to isolate this today to cherry-pick.

When I successfully cherry-pick a change (no conflicts, no merges), I
get a .git/MERGE_RR file left over.  After this happens, git-mergetool
will think there are no unresolved conflicts unless git (or I) first
removes the .git/MERGE_RR.

Maybe this only causes trouble for 'git stash apply' since it does not
employ rerere machinery, or because it takes some other code path
which does not begin by removing .git/MERGE_RR.

A naive fix would be to remove MERGE_RR at the conclusion of
'stash-apply', but I do not think that is the right place for it to
go.

Suggestions?

Phil
