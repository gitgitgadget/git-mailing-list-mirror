From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH 07/15] cache_tree_update(): Capability to handle tree
 entries missing from index
Date: Sun, 5 Sep 2010 15:09:24 -0600
Message-ID: <AANLkTikK9vGgtzrrAAyqptPVHM2wjOjK_cH6GB0rgewP@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-8-git-send-email-newren@gmail.com>
	<AANLkTi=ijbaATavcujUY-WnEfKFKrNue_kP6vSngKSvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 23:09:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsMSx-0007N5-0J
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 23:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab0IEVJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 17:09:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43702 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab0IEVJZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 17:09:25 -0400
Received: by fxm13 with SMTP id 13so2205133fxm.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FMdBoBFf9RFMDVivNRV2wHjNp+7QSYsyCjflYhDoLyU=;
        b=LRyyqD093F75XrBofydLMOz8LOsC8Budo5GvVuI2NOOOHp7sYCqRppqayqxsedjSob
         R8FofkXateioqUk710YVWAHzO4zZRXyS/hfjFjKYm+Y5PNx4cEXkvNO/Ou1U+JJs032s
         XTz0iRMNU6Nneb0Wt4JQzHpNKRfi4CtVS6vME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ds3hHm6Sqva6vOnftSA2kNs9dEYCPWpkeL10Ci3lU8ZneF+t2CHCY2lTEK3+wBu5Ni
         nmPcj/l2Nyetz4iR61IWsfkaDUAxB2MXSUglLhwiOGrLcldeDZfHwDvG0Sh0VLn92oiR
         zr7PWqnhybbCbah0B4JSlV7PX+JFggFuk7TpA=
Received: by 10.223.123.199 with SMTP id q7mr1659603far.84.1283720964659; Sun,
 05 Sep 2010 14:09:24 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Sun, 5 Sep 2010 14:09:24 -0700 (PDT)
In-Reply-To: <AANLkTi=ijbaATavcujUY-WnEfKFKrNue_kP6vSngKSvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155488>

n Sun, Sep 5, 2010 at 1:54 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com>=
 wrote:
> On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> wro=
te:
>> cache_tree_update() will write trees using the index. =C2=A0With spa=
rse clones,
>> the index will only contain entries matching the sparse limits, mean=
ing
>> that the index does not provide enough information to write complete=
 tree
>> objects. =C2=A0Having cache_tree_update() take a tree (typically HEA=
D), will
>> allow new complete trees to be constructed by using entries from the
>> specified tree outside the sparse limits together with the index.
>
> You are moving it closer to the index (from my view because I changed
> in commit_tree()). This makes me think, why don't you move the base
> tree into the index itself?
>
> The index is supposed to save the image of full worktree. While you
> don't have all path names, you have the clue to all of them, the base
> tree. To me, that means it belongs to the index. That would reduce
> code change to
> =C2=A0- cache-tree.c (generate new tree from the base tree and index)
> =C2=A0- read-cache.c (new sparse-clone index extension)
> =C2=A0- index writing operations (save the base tree in index): read-=
tree and merge

That's a really good idea.  I'll look into that.
