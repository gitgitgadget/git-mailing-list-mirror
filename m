From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 08/10] revert: Introduce HEAD, TODO files to persist
 state, plan
Date: Wed, 1 Jun 2011 20:58:08 +0530
Message-ID: <BANLkTino5gmfXjeOVih7+LHcMu1usPWAoQ@mail.gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com> <1306425233-504-9-git-send-email-artagnon@gmail.com>
 <20110526161102.GC24931@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 17:28:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRnLY-0001in-2G
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 17:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096Ab1FAP2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2011 11:28:31 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47846 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757921Ab1FAP23 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2011 11:28:29 -0400
Received: by wwa36 with SMTP id 36so6170659wwa.1
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=EMhRpwBJ7xc2VqYk3zqQapvQLMhSgnWd/R8qo+YiMUE=;
        b=g1PCowqXEEE28lH1stZiWxfmAgr0ViKKv40kVm0R2mbnwL9zrtB0BKnDKCISUysKE1
         un003+QroQ5nI31C/F17Se0ZsyEnDo3i0nZUpi2yyNb30KR6UL34+TDKA6kbFahj00W5
         BsJwVsilBnnYmavjBlPfdzEvIttaSsfL9B3mI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QbxElZzKrznVv1f+aeKQHX5YX0n/CWmaCqjVxI8QjfFwYW0o0J9LT7V+uCmF/Dh23L
         snyznchG/DA5nYuwGGfeKPNPrYqjqHy2YQ509ddGcxjfzoGqOpnJe0O12MN1TUxZo0zs
         UH2eeJktoWFSBYbwxBtdbDW9uOyHxc7HX3QFE=
Received: by 10.216.145.234 with SMTP id p84mr7071458wej.64.1306942108073;
 Wed, 01 Jun 2011 08:28:28 -0700 (PDT)
Received: by 10.216.51.68 with HTTP; Wed, 1 Jun 2011 08:28:08 -0700 (PDT)
In-Reply-To: <20110526161102.GC24931@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174869>

Hi Jonathan and others,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> Almost there. =C2=A0To comfort overly-worried people like me that thi=
nk we
> have not finished converted all die() calls yet, wouldn't this need t=
o
> look like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0persist_head(head);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((commit =3D ...)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int status_or_=
error;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Checkpoint.=
 =C2=A0If do_pick_commit exits, make sure the user
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * can still u=
se "git cherry-pick --continue" to recover.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0persist_todo(r=
evs.commits, opts);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status_or_erro=
r =3D do_pick_commit(...);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status_or_=
error)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return status_or_error;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Success! */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remove_todo(opts);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remove_head();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;

It's a little embarrassing, but I'm not able to figure out how to
persist the TODO early. prepare_revs() sets up the revision walker and
populates the rev_info struct: it contains a commit_list * in its
commits member, but I apparently can't access those directly -- I went
through some literature about revision walking and inspected how
get_revision must be used to iterate over all the individual commits.
Now, to persist the TODO, I need a commit_list to use: is there some
API I can use to avoid iterating over all the commits twice? Once to
populate the commit_list to persist the TODO, and the second time to
actually pick them?

Thanks.

-- Ram
