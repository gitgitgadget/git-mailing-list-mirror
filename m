From: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
Subject: Re: [PATCH] setup: translate symlinks in filename when using
	absolute paths
Date: Wed, 29 Dec 2010 09:35:12 +0000
Message-ID: <20101229093512.GA22963@sajinet.com.pe>
References: <1293447277-30598-1-git-send-email-carenas@sajinet.com.pe> <7vr5d1wuh0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguy???n Th??i Ng???c Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 10:35:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXsRC-0003Q0-LO
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 10:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867Ab0L2JfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 04:35:13 -0500
Received: from sajino.sajinet.com.pe ([76.74.239.193]:43312 "EHLO
	sajino.sajinet.com.pe" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab0L2JfM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 04:35:12 -0500
Received: by sajino.sajinet.com.pe (Postfix, from userid 1000)
	id 39A42A580F1; Wed, 29 Dec 2010 09:35:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vr5d1wuh0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164307>

On Tue, Dec 28, 2010 at 11:47:07AM -0800, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe> writes:
> 
> > otherwise, comparison to validate against work tree will fail when
> > the path includes a symlink and the name passed is not canonical.
> >
> > Signed-off-by: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
> 
> I take that "path" and "name passed" refer to the same thing (i.e. "path"
> parameter) in the above.

yes, and sorry for the cryptic description; you detailed below though this
is triggered by the fact that when using an absolute path filename as a
parameter detection for worktree is failing because it was normalized
through make_absolute_path.

> I think you are trying to handle the case where:
> 
>  - you give "/home/carenas/one" from the command line;
>  - $PWD is "/home/carenas"; and
>  - "/home/carenas" is a symlink to "/net/host/home/carenas"

this will be a valid  scenario, but the issue (with a different use case)
was reported in (which I missed to refer to when running git send-email):

  http://thread.gmane.org/gmane.comp.version-control.git/164212

> and the scan-from-the-beginning-of-string check done between
> "/home/carenas/one" and the return value of get_git_work_tree() which
> presumably is "/net/host/home/carenas" disagrees.  I wonder if a more
> correct solution might be to help get_git_work_tree() to match the notion
> of where the repository and its worktree are to the idea of where the user
> thinks they are, i.e. not "/net/host/home/carenas" but "/home/carenas", a
> bit better?

are you suggesting symlinks would be left untouched at least during
resolution for work_dir?, why is even necesary to resolve the links for
other users of that function?

Carlo
