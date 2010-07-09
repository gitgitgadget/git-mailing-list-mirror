From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: git-p4 move/delete errors
Date: Fri, 9 Jul 2010 23:32:46 +0200
Message-ID: <AANLkTilQtnIzNCcRzYzSqPEvXenHgND-_SAWmUeM64BH@mail.gmail.com>
References: <AANLkTinN0Av1CO7mZU-QKeApq43UmEykUV093eyTtKQN@mail.gmail.com>
	<AANLkTikPHJuf5JUe096BWTWO_oF9u3gNlVNuw7Ik32WQ@mail.gmail.com>
	<AANLkTin7eMFXT1FwZ2ojcAYgqIMSYnkz-uCoRlHvV6Tm@mail.gmail.com>
	<F94DAB9A-A06D-46ED-9AAA-EDE850365054@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tor Arvid Lund <torarvid@gmail.com>, git@vger.kernel.org
To: Lance Linder <llinder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 23:38:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXLHU-0002O4-Al
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 23:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864Ab0GIVin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 17:38:43 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61958 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab0GIVim convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 17:38:42 -0400
Received: by wwb24 with SMTP id 24so5360037wwb.1
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YtxyR8wd8OIbyWNrgrKDUbEpc9bgRrAWseXvppzLLqY=;
        b=fYMzkNSMq3O5eBMdydPteGplUjiA+e+vhDVYUuoWDAI2JKXEh3r1Ru0ilpTLXqF4M0
         BzL+kskvObD8F7cEbPGhrSQYO58CsN8sdTqbgZt5EcX8fpvd7fE+T+TPPEaxqr/hwrHq
         mp2wVtf7MuutAbFcsHrmFiygqEqRuduA8Gdts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nHFYooPXb8KmAdjJKv+pWlm0rWU6iFeaauAUOXnPi6ujslulaI1ZCEFs5fPik8d6u0
         du0zwuLlvZGS4GWZvOjuFB19duA04L11rmeLwKvC2/b/Hv8hpQ1DEDUa2VNBBjdx8zo0
         DS55ySRC3JxC0Zf0kd1Qb+aPk8CbRzxxvCSGE=
Received: by 10.216.180.202 with SMTP id j52mr4592737wem.112.1278711166546; 
	Fri, 09 Jul 2010 14:32:46 -0700 (PDT)
Received: by 10.216.55.197 with HTTP; Fri, 9 Jul 2010 14:32:46 -0700 (PDT)
In-Reply-To: <F94DAB9A-A06D-46ED-9AAA-EDE850365054@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150691>

On Fri, Jul 9, 2010 at 11:20 PM, Lance Linder <llinder@gmail.com> wrote:
> Thanks for the tip about keyword expansion. Fortunately for me we don't use those.

We don't either.

> When I was trying to debug this the problem seemed to be that the original file is removed from the local Perforce workspace before the p4 diff command is issued. I am not sure how the server upgrade caused this behavior but it was the only thing that changed when I first started seeing the error.

Hasn't Perforce always deleted files immediately when they are marked
for deletion?

Anyway, as far as I can see from the git-p4 source code, the command
is only used to generate the diff preview in the interactive window
that pops up when you "git p4 submit". So if you replace the line
diff = p4_read_pipe("diff -du ...")
with
diff = ""

it should start working again (the diff preview part will become
empty). I'm unable to test it right now, but fairly sure it will work.
I'll see if I can find a better solution when I have access to the
Perforce server again.

Thomas
