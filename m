From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: Merge two repos with history included? (was Re: How do I..?)
Date: Tue, 23 Dec 2008 10:58:01 +0300
Organization: HOME
Message-ID: <200812231058.02141.angavrilov@gmail.com>
References: <e1a4c7f60812221404k57a5e150kac74f53c784b6b4a@mail.gmail.com> <20081223004407.GZ21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Dylan Martin <dmartin@sccd.ctc.edu>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Dec 23 09:00:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF2BW-0007Bj-Dk
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 09:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbYLWH6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 02:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbYLWH6w
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 02:58:52 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:44402 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbYLWH6v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 02:58:51 -0500
Received: by bwz14 with SMTP id 14so9376180bwz.13
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 23:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZVpx+6ymBu5sXe490FXBkQc9WkS7V8wO5AjccuwSxXI=;
        b=Q+H09C3qHmt5ASWQAoFVcRbsp2KxXFufQ60Jwf88A1Cwot9yFrqKfjVDm0c83GBe2L
         bKBs3q6jvx4+DfHZPGcJGBUSm/orDwyQ7o9aC5J6K68iaptLTXahiJ+VPhJOoSgU1ZAU
         18zme5mbwuyz9rNUh2ZZClRCCRGk6GAE0DOB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QgeH7yT5OVMJs7L8NDASWLpP7ZKUoAklC7H9iILVtYWEbR+Y55G6pyfwtia4AuAvXL
         ZV29v9TkTV3vTyUcvZi7o/HClQubAF5UOp9z5Mc+YZrZJpzKThVkb2Ea57OpJRb6b0XU
         jXQtNERtZXFzNR8AjscQUjpbme4PpQr+TL6J0=
Received: by 10.223.116.10 with SMTP id k10mr5697667faq.100.1230019119392;
        Mon, 22 Dec 2008 23:58:39 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id g28sm10527100fkg.1.2008.12.22.23.58.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Dec 2008 23:58:38 -0800 (PST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.7-134.fc10.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <20081223004407.GZ21154@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103802>

On Tuesday 23 December 2008 03:44:07 Miklos Vajna wrote:
> On Mon, Dec 22, 2008 at 02:04:06PM -0800, Dylan Martin <dmartin@sccd.ctc.edu> wrote:
> > I checked, and my initial SVN to git conversion does contain history.
> > 
> > I'm trying to add an exising repo as a subdir of my main repo with
> > history included.  Can anyone tell me how to do that?
> 
> I would try the following: Let's say you have super.git and foo.git, and
> you want to merge foo.git to the subdirectory 'foo' of super.git. Then
> you can do in foo.git:
> 
> mkdir foo
> mv * foo
> git add foo
> git commit -a
> 
> Then in super.git:
> 
> git pull path/to/foo.git master
> 
> And then git log --follow should work just fine on any merged files as
> well.
> 


If the conversion is one-shot, you can also try rewriting commits like this:

cd foo.git
git filter-branch --commit-filter 'TREE=$1; shift; git commit-tree $(echo -e "040000 tree $TREE\tfoo" | git mktree) "$@"' master

(Maybe there is a simpler way, though)

I used this once to merge together the history of a bunch of interrelated (and now dead) projects.

Alexander
