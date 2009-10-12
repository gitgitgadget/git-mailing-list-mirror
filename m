From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/4] plumbing to help fix git-gui
Date: Mon, 12 Oct 2009 00:25:36 -0500
Message-ID: <20091012052536.GA11106@progeny.tock>
References: <4AD0C93C.6050306@web.de>
 <7vws327wbp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 07:18:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxDIM-0005lU-OA
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 07:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbZJLFRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 01:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbZJLFRs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 01:17:48 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:52310 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbZJLFRr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 01:17:47 -0400
Received: by yxe26 with SMTP id 26so3249337yxe.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 22:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gn/uhcotD+vSRJmzAhHtJQjTto9poJjtsVXIWGxtUWk=;
        b=OVCVm0C3H1SgPFGfhayXo2094QlTw78vwCeIvSl1s+O/oUJV+uLo4p3tNmizRj8IOI
         FRJlqzl9A5836F23+4bK+8sv18wd787fFTeWkwGqFfzIocvqAGiiraoqlIlFw/8yquHX
         abD+VpvOUh11+2XAsfIPjUwsyVwsThYGW1S7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ldbx4ocRomYo8mpjNUtzes4NsLGKNwV8f03xaJIZQdRpjgVOsdJZg+qPe84j+PRwcn
         8o1c1zKy6PNK4cHGR0tsEBT20HwX17ggL+iJOHbvmSGxQfVjYzM/Hl4pk33aiduUW6//
         g4bukIBNmif0/IF5V/q0MlWJxgQthDqbCzl/0=
Received: by 10.101.180.33 with SMTP id h33mr5045942anp.155.1255324631141;
        Sun, 11 Oct 2009 22:17:11 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2084041yxe.13.2009.10.11.22.17.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 22:17:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vws327wbp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129979>

Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:

>> I became aware of this issue while looking into problems occuring
>> when a user created a branch starting with a '/' in git gui (e.g.
>> "/foo"). Strange things happen, while git gui shows the current
>> branch as "/foo" under the hood a branch "foo" (without the slash)
>> had been created. But then you can't delete "/foo" from git gui,
>> because a branch of that name doesn't exist.
> 
> Perhaps an interface to give a cleaned-up version, e.g.
> 
>     $ git check-ref-format --print refs/heads//foo/bar
>     refs/heads/foo/bar
> 
> is what you want in order to fix git-gui?  I dunno.

The following packages do exactly that.  I tried to use it to fix
git gui, but my Tcl-fu was not up to it, at least for tonight.

It is not obvious to me that this interface is the one that would be
most helpful for git gui: probably a command to just munge the branch
name would be more convenient, though less general.

Is the --print option useful?  Right now, it seems that its main use is
documentation.  But in the future, it would be very nice if this command
could be used to transform Unicode ref names to some appropriate
normalization form, to make Unicode ref names usable in Mac OS X and
less confusing everywhere.

I look forward to your thoughts.

Jonathan Nieder (4):
  Add tests for git check-ref-format
  Documentation: describe check-ref-format --branch in more detail
  check-ref-format: add option to print canonical name
  check-ref-format: Simplify --print implementation

 Documentation/git-check-ref-format.txt |   32 ++++++++++++----
 builtin-check-ref-format.c             |   31 ++++++++++++++++
 t/t1402-check-ref-format.sh            |   61 ++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 8 deletions(-)
 create mode 100644 t/t1402-check-ref-format.sh
