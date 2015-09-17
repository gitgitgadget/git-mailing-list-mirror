From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR':
 Permission denied
Date: Thu, 17 Sep 2015 20:18:21 +0700
Message-ID: <CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
References: <1440157010.1759.83.camel@transmode.se> <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
 <1442245035.10125.18.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Thu Sep 17 15:19:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcZ5U-0006lR-FD
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 15:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbbIQNSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 09:18:53 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33333 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbIQNSv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 09:18:51 -0400
Received: by igbkq10 with SMTP id kq10so12069219igb.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hR//35mR8LU/Cncoz8Tb/1R6B1YBlRDta9/XxctW/6s=;
        b=G5vsCC3L+p+tXb1WkrdwQ7Gmeu1xI9uMTpsT3awpVbxbMf+MSn+uAXSg9PudSZxQWV
         cb+8wBIqDVigWTiy+noZysG82ID6bvt0DIhpaAyFqyItOQh2CVH06QHf8JCUDah4nnH7
         C5r5LZWEiT9cT+3nL/CKhk4+8p13/v2lJgkLBBdRqkJ9uCUUYTxYQ9dzi3N4LKVxu8eU
         1grEn6JYipyDXPrmMQShvVFB9KpjYgdKhxF3x9hXIVOWwM2F/X3/w0JQP2Q+CQOxsZjI
         YtETWw75xnTavLwORJ1X4+aAm6LRP2chvcLzSQNiL8GCecPdPZe+Q+xc614d+XN17Erw
         Z0cw==
X-Received: by 10.50.147.100 with SMTP id tj4mr6358295igb.65.1442495930769;
 Thu, 17 Sep 2015 06:18:50 -0700 (PDT)
Received: by 10.107.19.227 with HTTP; Thu, 17 Sep 2015 06:18:21 -0700 (PDT)
In-Reply-To: <1442245035.10125.18.camel@transmode.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278113>

On Mon, Sep 14, 2015 at 10:37 PM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
> On Mon, 2015-08-31 at 16:56 +0700, Duy Nguyen wrote:
>> On Fri, Aug 21, 2015 at 6:36 PM, Joakim Tjernlund
>> <joakim.tjernlund@transmode.se> wrote:
>> > I cannot push:
>> > # > git push origin
>> > Login for jocke@git.transmode.se
>> > Password:
>> > Counting objects: 7, done.
>> > Delta compression using up to 4 threads.
>> > Compressing objects: 100% (7/7), done.
>> > Writing objects: 100% (7/7), 13.73 KiB | 0 bytes/s, done.
>> > Total 7 (delta 4), reused 0 (delta 0)
>> > fatal: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission
>> > denied
>> > fatal: The remote end hung up unexpectedly
>> > fatal: The remote end hung up unexpectedly
>>
>> Noted. Will try to fix (but probably not fast). At first I thought
>> this was an old bug, but that old bug [1] is in the fetch/clone path,
>> not push. Not sure if the same approach can be reused here (i.e.avoid
>> temp files altoghether).
>>
>> [1] b790e0f (upload-pack: send shallow info over stdin to pack-objects
>> - 2014-03-11)
>
> Noticed I had forgotten to reply ...
>
> An even simpler fix would be to have an tmp dir within the repo, aka:
>  /var/git/tmv3-target-overlay.git/tmp/shallow_Un8ZOR
> This would cover all cases when one must create a tmp file

Sorry for my silence. I intend to put these temp files in $TMPDIR by
resurrecting (part of) this patch [1]. Maybe tomorrow.

But if you build your own, you can put them in $GIT_DIR/tmp by
replacing "shallow_XXXXXX" in setup_temporary_shallow() in shallow.c
with "tmp/shallow_XXXX". You need to create the directory "tmp" in
advance though, or do
"safe_create_leading_directories_const(git_path("tmp/shallow_XXXXX"));"
before xmkstemp()

[1] http://article.gmane.org/gmane.comp.version-control.git/242787
-- 
Duy
