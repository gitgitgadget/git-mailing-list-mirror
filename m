From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Stgit and refresh-temp
Date: Sun, 23 Nov 2008 21:20:59 +0000
Message-ID: <b0943d9e0811231320s804eff0k5aecbac84cb2ffe7@mail.gmail.com>
References: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com>
	 <20081107054419.GA27146@diana.vm.bytemark.co.uk>
	 <b0943d9e0811110959t4eb236bvd648fbca5e482911@mail.gmail.com>
	 <20081112080103.GA25454@diana.vm.bytemark.co.uk>
	 <b0943d9e0811120202wae88381j9fbc9f919b49dce5@mail.gmail.com>
	 <20081112101439.GA27469@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 22:22:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4MPV-0006a1-Jc
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 22:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbYKWVVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Nov 2008 16:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbYKWVVD
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 16:21:03 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:46327 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbYKWVVB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Nov 2008 16:21:01 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2032575fkq.5
        for <git@vger.kernel.org>; Sun, 23 Nov 2008 13:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=R7HBukBtXeHLeMOOMl0e61pDlMpSYb3M09ft51Ns7QY=;
        b=lmWXX2WbxftFhT72QB0Kefm7Dota9b0IpGL59yUW7wTgqiccVS8RVBhXUE/ALDQy55
         JWSiymo/zHl2OBVy24mMp9FZcJovAA/MmkDwIZcljOPQcthJ9PJudq7EjsFSmtVxs/p3
         kAFyoArxvZ5NW8PFxUCvrjB6rizCLhKLCYWUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PLgC3M4pn7un1Uxgq13jRQGsZUZwIe7qKEB8ojFIIBv5aeIRit7Yh1bhGonwiOiLzW
         cakK3hBjbiCr+c0O8yhy4TLhNbDOyeMYmF5G3HOcP+qqm0JUTitAjlPht99mHyFmBhnh
         rRjTCmR0PIHZCvjAqkLQQa4rdtYQKiJAD8i0U=
Received: by 10.187.247.15 with SMTP id z15mr410106far.80.1227475259219;
        Sun, 23 Nov 2008 13:20:59 -0800 (PST)
Received: by 10.187.191.12 with HTTP; Sun, 23 Nov 2008 13:20:59 -0800 (PST)
In-Reply-To: <20081112101439.GA27469@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101579>

2008/11/12 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-11-12 10:02:10 +0000, Catalin Marinas wrote:
>
>> I think it's just a matter of updating HEAD on the "merge_conflict"
>> path but I'm still not fully confident in modifying the new lib
>> infrastructure.
>
> You're probably right.

The simple patch below seems to fix it the goto issue. Could you
please confirm its correctness (the patch might be wrapped by the web
interface)?

diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 6623645..0f414d8 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -321,6 +321,7 @@ class StackTransaction(object):
         if any(getattr(cd, a) !=3D getattr(orig_cd, a) for a in
                ['parent', 'tree', 'author', 'message']):
             comm =3D self.__stack.repository.commit(cd)
+            self.head =3D comm
         else:
             comm =3D None
             s =3D ' (unmodified)'

Thanks.

--=20
Catalin
