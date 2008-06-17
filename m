From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: git-svn equivalent to "svn switch --relocate"
Date: Tue, 17 Jun 2008 17:42:14 -0400
Message-ID: <e06498070806171442s6c097884j76ed6c98908a3eb1@mail.gmail.com>
References: <20080617160602.GB29897@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sam Hocevar" <sam@zoy.org>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:43:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8ixV-00051r-Ei
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 23:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759894AbYFQVm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 17:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759888AbYFQVm1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 17:42:27 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:11299 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759871AbYFQVmY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 17:42:24 -0400
Received: by an-out-0708.google.com with SMTP id d40so1358508and.103
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UFr3jSESO9W7jnBMh5EQ+2HQl9Dgs+ZpSeTC+XcNVzw=;
        b=v320y4W85+m6BAXFNEcxCBJP4Uyu5/2MoAMK/8Dp5ST/Xr2lpd13WCUn7geb+SCcp4
         bf9FNxJ1YbXg5rYhVDhrsjpx/9XJ7uY3WZjG1FqAtOvYhmcCz1IspkPjdd+YJvYaatiU
         EsDBaDoJjJvDTjLnpQAzL8fNjRN1E01w8vDns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nf+ik1r/AU9wPXvDQgk7zN4G6IyjNBpCwa7LsWMtAWoC8vuOW4oVlqXqlb5QONMoxP
         cq+4CuM8fZgw/2tvUeHlqRFAM9f/Utoqv7KXV9ycaAIhrBXHmSZh8Kz9hOI1Bk0EFRmO
         Kqr1MzjjPT2NYn2wsxUaDiAtCtLHt8ICsRYiI=
Received: by 10.100.34.16 with SMTP id h16mr11636505anh.46.1213738934329;
        Tue, 17 Jun 2008 14:42:14 -0700 (PDT)
Received: by 10.100.92.6 with HTTP; Tue, 17 Jun 2008 14:42:14 -0700 (PDT)
In-Reply-To: <20080617160602.GB29897@zoy.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85326>

On Tue, Jun 17, 2008 at 12:06 PM, Sam Hocevar <sam@zoy.org> wrote:
>   I know this has been addressed a few times, but since I haven't found
> any reasonable way to relocate a git-svn repository (after a protocol
> change, or a server name change) I thought I'd share how I did it.
>
>   Step 1 is to edit ".git/config" and modify the "url = " line so
> that it reflects the new repository address. For instance:
>
> -       url = http://svn.gnome.org/svn/gimp
> +       url = svn+ssh://svn.gnome.org/svn/gimp
>
>   From now on, git-svn will basically stop working, because the
> "git-svn-id:" lines in the commit logs will no longer match its
> configuration. And git-filter-branch is of no use here either, because
> it will change the md5sum of each commit, and git-svn will no longer be
> able to track the commits.

It is not so hard to work around this problem.  After you run
filter-branch, make sure the ref used by git-svn in refs/remotes
points to the new (altered) hash.  Then, delete the .git/svn/<remote>
directory corresponding to the svn-remote you changed (trunk,
probably).  When you next run "git svn fetch", git-svn will regenerate
its revmap using the new hash, and everything should be peachy after
that.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
