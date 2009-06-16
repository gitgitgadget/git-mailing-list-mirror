From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Tue, 16 Jun 2009 07:10:36 +0100
Message-ID: <e5bfff550906152310m1dc92bf7vf73fdb8f925e2fb7@mail.gmail.com>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de>
	 <e5bfff550906151445m2f38c3fw964e01251d9568b9@mail.gmail.com>
	 <e5bfff550906151507t3f6ccf39j177f7c39d8495f5a@mail.gmail.com>
	 <200906160153.28018.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Tue Jun 16 08:15:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGRxN-0005Bc-Ir
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 08:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937679AbZFPGKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 02:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937674AbZFPGKg
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 02:10:36 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:48203 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937664AbZFPGKe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 02:10:34 -0400
Received: by ey-out-2122.google.com with SMTP id 25so401324eya.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 23:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KRme4Qb86dBFD3sNbBhZidHrlA/gNgKSH739YoWb5JY=;
        b=ExKmRwZh73XZk7g1qQfSUUWvOTnFs/iua55FZyR1+3oXr0eDdo9IMNf+F8MGFA2gVv
         kywjQyKVm8aXOW5hDcf1jLQagVstJPIiFljQblYUAF1mCcXijh5XVnxMdgWBxBQHs8QS
         SjS1Vm2wZd9TvWX2OCyxNodMjXJdzbfwkYuYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ux96E+xKLIm8w4c06mE5HnKp+sINswWZL60KPOry9CLWfzCUuSAUetTC2V7989f5Cl
         hFc9ntsGMFFOTk2DxKe2lc9NKhLV6N7BXqLGFEOnyKCPFfVUvB8Z4p23tj1fFbZxMQKc
         OxdhrQBSnCoxOdslxAexbx3MPczI9vGT0E3Jo=
Received: by 10.216.19.17 with SMTP id m17mr2591461wem.187.1245132636467; Mon, 
	15 Jun 2009 23:10:36 -0700 (PDT)
In-Reply-To: <200906160153.28018.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121657>

On Tue, Jun 16, 2009 at 00:53, Markus
Heidelberg<markus.heidelberg@web.de> wrote:
>
> Yes, it works. Thanks. Would it make sense and be possible to fix it
> directly in ListView::getSelectedItems()?
>

I am not sure it is a problem of the selected items set. Unfortunatly
it is not ordered, but actually this was not documented, so it was my
bad to assume rows are always ordered because it happens they are
sorted with Qt4.3.3

And also ordering in Git::formatPatch() is easier because the "tools"
like appendNamesWithId() are already there and only there.

Another reason is that is Git::formatPatch() that needs the rows to be
ordered, so has a sense to do it there where is needed. Of corse if
other places of QGit requires that the rows returned by
ListView::getSelectedItems() should be ordered then we can move the
ordering in ListView::getSelectedItems() as you suggest, or, even
better, move the ordering in ListView::getSelectedItems() but from
there call a new helper function Git::sortShaByIndex() that does the
work and is defined in git.cpp because should use internal information
like the index and call directly the sha database.

Yes, a possible cleanup / reformat job could be to:

- Add a new public helper function Git::sortShaByIndex() defined in git.cpp

- Call from ListView::getSelectedItems() when we get the list of sha
user as select

- Document ListView::getSelectedItems() always returns a list of ordered sha's


> BTW, a nice way to see the created git-format-patch command without
> modifying the sources is to use a directory with spaces, which is not
> handled correctly by qgit.
>


????

I cannot test now, but this seems a bug.
