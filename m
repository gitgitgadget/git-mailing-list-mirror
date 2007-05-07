From: Steven Grimm <koreth@midwinter.com>
Subject: Re: importing multi-project svn repositories
Date: Mon, 07 May 2007 11:06:13 -0700
Message-ID: <463F6A95.30207@midwinter.com>
References: <C05C5EF4-EC68-490B-946E-630117393F4E@drhanson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Hanson <drh@drhanson.net>
X-From: git-owner@vger.kernel.org Mon May 07 20:06:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl7bZ-0005c2-To
	for gcvg-git@gmane.org; Mon, 07 May 2007 20:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966107AbXEGSGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 14:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966111AbXEGSGQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 14:06:16 -0400
Received: from tater.midwinter.com ([216.32.86.90]:54706 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966107AbXEGSGP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 14:06:15 -0400
Received: (qmail 24179 invoked from network); 7 May 2007 18:06:14 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=m9R8g7CV0vCMjq01phCzoKez4JR9FGXijtEMI8wu7GSkzAP6mN/X3jo1gYJphmuF  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 7 May 2007 18:06:14 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <C05C5EF4-EC68-490B-946E-630117393F4E@drhanson.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46474>

David Hanson wrote:
> I'd like to import calc at the top level, put calc/tags/foo in git's 
> tags/calc/foo and calc/branches/baz in git's heads/calc/baz. Ditto for 
> calendar, spreadsheet, etc.

Try git-svn rather than git-svnimport. The latter, AFAIK, is no longer 
really maintained. The former will do what you want pretty easily. You 
just run it like

git svn clone --prefix=calc/ -T trunk -t tags -b branches \
    http://svn/repo/url/calc gitrepo

and it'll create a git repository called "gitrepo" with the calc 
project's trunk/tags/branches as git tags. Then do

git svn clone --prefix=spreadsheet/ -T trunk -t tags -b branches \
    http://svn/repo/url/spreadsheet gitrepo

and it will add the spreadsheet branches to the same repo. The 
"--prefix" option is needed to keep the branch namespaces from 
overlapping. git-svn will make an attempt to figure out the correct 
history of the branches and tags relative to the trunk so they look like 
sane git branches.

If you want to be able to check out calc and spreadsheet simultaneously, 
then you probably need to use git's submodule support, which is kind of 
a work in progress at the moment.

-Steve
