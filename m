From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: resumable git-clone?
Date: Wed, 8 Aug 2007 07:20:59 -0400
Message-ID: <fcaeb9bf0708080420t192596f0kfabbaa5b058d49e5@mail.gmail.com>
References: <fcaeb9bf0708070623p24f1cae2q2af959a89738c4e8@mail.gmail.com>
	 <20070808035946.GP9527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 13:21:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIjbZ-0008VX-Q2
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 13:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbXHHLVE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 07:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbXHHLVC
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 07:21:02 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:64113 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbXHHLVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 07:21:00 -0400
Received: by an-out-0708.google.com with SMTP id d31so23693and
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 04:20:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FoOXJlOrHoteTVzF11YDTD5FK3rclZRwwPSth5KfNReK2cFdWwkw6FOhV4Xlu9kNIaOKt6Q/EYAo9hdydMNMaeQ6RCSj7wBNQfp0Qg94LLAUTzQzbrQUjfuqSj7OgmM56d/zvvQxn8uNH4w2wJyQjvuxLsaYH2BEp9SLP1/1wU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s9CQE7idHALD4udjU6F9g76TLPuL6hS6s+fizaM5nPwqvX07T3rI+ZR+C++FulV86m99MmXV4W3l8rRPg3DajT3nTRs50KmISyZg65lzSpHjhDe1zh9V0s5Z0IBGSCJe9O7danFJTQybL+QaBpIxIcr7CoInfttOzza0OLHSXlc=
Received: by 10.100.10.20 with SMTP id 20mr1122837anj.1186572059481;
        Wed, 08 Aug 2007 04:20:59 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Wed, 8 Aug 2007 04:20:59 -0700 (PDT)
In-Reply-To: <20070808035946.GP9527@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55317>

On 8/7/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > I was on a crappy connection and it was frustrated seeing git-clone
> > reached 80% then failed, then started over again. Can we support
> > resumable git-clone at some level? I think we could split into several
> > small packs, keep fetched ones, just get missing packs until we have
> > all.
>
> This is uh, difficult over the native git protocol.  The problem
> is the native protocol negotiates what the client already has and
> what it needs by comparing sets of commits.  If the client says
> "I have commit X" then the server assumes it has not only commit
> X _but also every object reachable from it_.
>
> Now packfiles are organized to place commits at the front of the
> packfile.  So a truncated download will give the client a whole
> host of commits, like maybe all of them, but none of the trees
> or blobs associated with them as those come behind the commits.
> Worse, the commits are sorted most recent to least recent.  So if
> the client claims he has the very first commit he received, that
> is currently an assertion that he has the entire repository.

I'm thinking about things like bisect and use it to cut the history
into parts. Clients only use completed parts. Uncompleted parts are
thrown away. So if users think they cannot suffer too big packs, they
tell server to send smaller (and less efficient) packs. Anyway I don't
have deep knowledge of Git internals, my opion could be completely
wrong.
-- 
Duy
