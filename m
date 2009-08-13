From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Thu, 13 Aug 2009 19:38:09 +0700
Message-ID: <fcaeb9bf0908130538x396b1208s43d312107e3e198c@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-4-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-5-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-6-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-7-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-8-git-send-email-pclouds@gmail.com>
	 <1250005446-12047-9-git-send-email-pclouds@gmail.com>
	 <7v3a7xa6e5.fsf@alter.siamese.dyndns.org>
	 <fcaeb9bf0908130020meaed129j5d6a4f04a6878bd0@mail.gmail.com>
	 <m3skfwnihn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 14:38:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZZV-0005xw-7M
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbZHMMiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 08:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbZHMMiK
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:38:10 -0400
Received: from mail-yw0-f193.google.com ([209.85.211.193]:37499 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbZHMMiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 08:38:09 -0400
Received: by ywh31 with SMTP id 31so931380ywh.4
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VV2/hiiMe8+b+Ad1d3RqU/IutMApE61wC4xGz87uJes=;
        b=lq3cfxvPhZIJia+Eytr8DMZfiBG/ZtZSV6fSu0be+cNrYZUicoA5+vkQQsfZGYLJne
         b+JWWAs3KS5KZvzwYpBoBVUZCjk+TDNIi+hMAmIyzoElr/wqkI8zxJZ6bYmTYtBTT0Pk
         FD7+odLx6DrOVr8WgO3vhFGsz1zQtppm080XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UJHPnl4Ba0mtyJWzlFLeMqzE+xWEO+tmc8Dp36Qru4h5z4tKhjqh+jmHbGR8XKqTWO
         UX5v5e039IZpbdYf5JP2ClBaPEiRGpsUUQVlU4h/6U5XaBjVslJhWEpmBIaY4sTmnDSs
         ZI1SPR4XrthJNKrxGdCbmGQtQprL8QJwEdRfE=
Received: by 10.100.166.13 with SMTP id o13mr917573ane.118.1250167089920; Thu, 
	13 Aug 2009 05:38:09 -0700 (PDT)
In-Reply-To: <m3skfwnihn.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125817>

On 8/13/09, Jakub Narebski <jnareb@gmail.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>  > 2009/8/12 Junio C Hamano <gitster@pobox.com>:
>
>  > > It could also require core.sparseworktree configuration set to true if we
>  > > are really paranoid, but without the actual sparse specification file
>  > > flipping that configuration to true would not be useful anyway, so in
>  > > practice, giving --sparse-work-tree option to these Porcelain commands
>  > > would be no-op, but --no-sparse-work-tree option would be useful to
>  > > ignore $GIT_DIR/info/sparse and populate the work tree fully.
>  >
>  > Only part "ignore $GIT_DIR/info/sparse" is correct.
>  > "--no-sparse-work-tree" would not clear CE_VALID from all entries in
>  > index (which is good, if you are using CE_VALID for another purpose).
>  >
>  > To quit sparse checkout, you must create an empty
>  > $GIT_DIR/info/sparse, then do "git checkout" or "git read-tree -m -u
>  > HEAD" so that the tree is full populated, then you can remove
>  > $GIT_DIR/info/sparse. Quite unintuitive..
>
>
> Hmmm... this looks like either argument for introducing --full option
>  to git-checkout (ignore CE_VALID bit, checkout everything, and clean
>  CE_VALID (?))...
>
>  ...or for going with _separate_ bit for partial checkout, like in the
>  very first version of this series, which otherwise functions like
>  CE_VALID, or is just used to mark that CE_VALID was set using sparse.

In my opinion, making an empty .git/info/sparse to fully populate
worktree is not too bad. I wanted to have plumbing-level support in
git so that you could try sparse checkout on your projects (possibly
with a few additional scripts to make your life easier). Then good
Porcelain UI may emerge later (or in worst case, people would roll
their own sparse checkout).
-- 
Duy
