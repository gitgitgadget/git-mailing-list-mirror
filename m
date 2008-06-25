From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Where does gitweb take the owner name from?
Date: Wed, 25 Jun 2008 17:50:18 +0200
Message-ID: <g3tpfs$9a4$1@ger.gmane.org>
References: <ce513bcc0806250741q3821e925uf8b6439b12062ba2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 17:51:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBXHP-0002ZK-MX
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 17:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbYFYPug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 11:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbYFYPug
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 11:50:36 -0400
Received: from main.gmane.org ([80.91.229.2]:49797 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbYFYPuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 11:50:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBXGN-0003Xg-9N
	for git@vger.kernel.org; Wed, 25 Jun 2008 15:50:27 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 15:50:27 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 15:50:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <ce513bcc0806250741q3821e925uf8b6439b12062ba2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86291>

Erez Zilber venit, vidit, dixit 25.06.2008 16:41:
> Hi,
> 
> On the main page of gitweb (the one that lists all projects), there's
> an "Owner" column. On my gitweb, it is empty for all projects. Where
> is this information taken from?
> 
> Here is how it looks on the server when I run 'ls -l':
> 
> drwxr-xr-x 7 erez.zilber linux 4096 Jun 25 17:36 my_test.git
> 
> Thanks,
> Erez

Sources considered by gitweb are:
1. projectlist file
2. owner key in .git/config ("gitweb.owner")
3. file owner of the git dir

It's funny this results in an empty owner in your case: What does 
"finger erez.silber" say?

Michael

Use the source, Luke ;)

sub git_get_project_owner {
         my $project = shift;
         my $owner;

         return undef unless $project;
         $git_dir = "$projectroot/$project";

         if (!defined $gitweb_project_owner) {
                 git_get_project_list_from_file();
         }

         if (exists $gitweb_project_owner->{$project}) {
                 $owner = $gitweb_project_owner->{$project};
         }
         if (!defined $owner){
                 $owner = git_get_project_config('owner');
         }
         if (!defined $owner) {
                 $owner = get_file_owner("$git_dir");
         }

         return $owner;
}
