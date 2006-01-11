From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH] stgit: fix clone
Date: Wed, 11 Jan 2006 17:39:18 -0500
Organization: Network Appliance, Inc.
Message-ID: <43C58916.6030409@citi.umich.edu>
References: <1137017966.10975.8.camel@dv>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080402030109030004070200"
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 23:39:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewocm-0002pa-7v
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 23:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWAKWjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 17:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWAKWjV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 17:39:21 -0500
Received: from mx1.netapp.com ([216.240.18.38]:61260 "EHLO mx1.netapp.com")
	by vger.kernel.org with ESMTP id S932348AbWAKWjU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2006 17:39:20 -0500
Received: from smtp1.corp.netapp.com ([10.57.156.124])
  by mx1.netapp.com with ESMTP; 11 Jan 2006 14:39:21 -0800
X-IronPort-AV: i="3.99,357,1131350400"; 
   d="vcf'?scan'208"; a="282879290:sNHT23273300"
Received: from svlexc02.hq.netapp.com (svlexc02.corp.netapp.com [10.57.157.136])
	by smtp1.corp.netapp.com (8.13.1/8.13.1/NTAP-1.6) with ESMTP id k0BMdKot022246;
	Wed, 11 Jan 2006 14:39:20 -0800 (PST)
Received: from exsvl02.hq.netapp.com ([10.56.8.60]) by svlexc02.hq.netapp.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 11 Jan 2006 14:39:20 -0800
Received: from [10.98.28.98] ([10.98.28.98]) by exsvl02.hq.netapp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 11 Jan 2006 14:39:19 -0800
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1137017966.10975.8.camel@dv>
X-OriginalArrivalTime: 11 Jan 2006 22:39:19.0657 (UTC) FILETIME=[DC62C590:01C616FF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14520>

This is a multi-part message in MIME format.
--------------080402030109030004070200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi pavel-

exactly where does the clone operation fail?  is it at the checkout step?

seems to me the "git clone" script should create an environment where 
"git-rev-parse --git-dir" ought to work correctly.

Pavel Roskin wrote:
> "stg clone" is currently broken:
> 
> $ stg clone http://homepage.ntlworld.com/cmarinas/stgit.git    
> stg clone: git-rev-parse --git-dir failed
> 
> This happens with current git.  "git-rev-parse --git-dir" doesn't work
> in an empty directory.  The patch avoids running "git-rev-parse
> --git-dir" when the requested command doesn't assume existence of git
> repository.
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>
> 
> ---
> Warning: this is my first non-trivial patch to StGIT and the first patch
> to a Python program.
> 
> diff --git a/stgit/git.py b/stgit/git.py
> index a7b1c3f..0e63f69 100644
> --- a/stgit/git.py
> +++ b/stgit/git.py
> @@ -82,13 +82,16 @@ __commits = dict()
>  # Functions
>  #
>  
> -def get_base_dir():
> +def get_base_dir(assume_top = False):
>      """Different start-up variables read from the environment
>      """
>      if 'GIT_DIR' in os.environ:
>          return os.environ['GIT_DIR']
>      else:
> -        return _output_one_line('git-rev-parse --git-dir')
> +        if assume_top:
> +            return '.git'
> +        else:
> +            return _output_one_line('git-rev-parse --git-dir')
>  
>  def get_commit(id_hash):
>      """Commit objects factory. Save/look-up them in the __commits
> diff --git a/stgit/stack.py b/stgit/stack.py
> index 8b7c296..1c080b3 100644
> --- a/stgit/stack.py
> +++ b/stgit/stack.py
> @@ -263,7 +263,7 @@ class Series:
>              self.__name = git.get_head_file()
>  
>          if self.__name:
> -            base_dir = git.get_base_dir()
> +            base_dir = git.get_base_dir(assume_top = (name == 'master'))
>              self.__patch_dir = os.path.join(base_dir, 'patches',
>                                              self.__name)
>              self.__base_file = os.path.join(base_dir, 'refs', 'bases',
> 
> 


--------------080402030109030004070200
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Open Source NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://troy.citi.umich.edu/u/cel/
version:2.1
end:vcard


--------------080402030109030004070200--
