From: Daniel Fahlke <flyingmana@cotya.com>
Subject: Re: [PATCH] show signature of commit in gitk
Date: Sun, 13 Dec 2015 15:15:30 +0100
Message-ID: <566D7D82.90107@cotya.com>
References: <565F443D.7050205@cotya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 15:16:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a87Ru-0003EB-QR
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 15:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbbLMOPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 09:15:51 -0500
Received: from mailserv.regfish.com ([79.140.61.33]:56487 "EHLO
	mailserv.regfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbbLMOPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 09:15:51 -0500
Received: (qmail 8429 invoked from network); 13 Dec 2015 14:15:48 -0000
Received: from x4db38424.dyn.telefonica.de (HELO [192.168.0.103]) (49250-0001@[77.179.132.36])
          (envelope-sender <flyingmana@cotya.com>)
          by mailserv.regfish.com (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <gitster@pobox.com>; 13 Dec 2015 14:15:48 -0000
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <565F443D.7050205@cotya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282331>

It seems my Patch got no attention yet, is there anything wrong? 
Do I need to ping someone in particular?

On 12/02/2015 08:19 PM, Daniel Fahlke wrote:
> but still depending on the added --show-signature as argument
> 
> longer explanation:
> git supports for some time now signed commits, and also show the
> signature and its trust level inside the `git log` command.
> Now, it can also get shown in gitk.
> 
> Signed-off-by: Flyingmana <flyingmana@googlemail.com>
> ---
>  gitk-git/gitk | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index fcc606e..54c167f 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -1674,6 +1674,7 @@ proc parsecommit {id contents listed} {
>      set audate {}
>      set comname {}
>      set comdate {}
> +    set comgpg {}
>      set hdrend [string first "\n\n" $contents]
>      if {$hdrend < 0} {
>  	# should never happen...
> @@ -1690,6 +1691,9 @@ proc parsecommit {id contents listed} {
>  	} elseif {$tag == "committer"} {
>  	    set comdate [lrange $line end-1 end]
>  	    set comname [join [lrange $line 1 end-2] " "]
> +	} elseif {$tag == "gpg:"} {
> +	    append comgpg [join [lrange $line 1 end] " "]
> +	    append comgpg "\n"
>  	}
>      }
>      set headline {}
> @@ -1726,7 +1730,7 @@ proc parsecommit {id contents listed} {
>  	set comment [string range $comment 0 $i-1]
>      }
>      set commitinfo($id) [list $headline $auname $audate \
> -			     $comname $comdate $comment $hasnote $diff]
> +			     $comname $comdate $comment $hasnote $diff $comgpg]
>  }
>   proc getcommit {id} {
> @@ -7325,6 +7329,7 @@ proc selectline {l isnew {desired_loc {}}
> {switch_to_patch 0}} {
>      $ctext insert end "[mc "Author"]: [lindex $info 1]  $date\n"
>      set date [formatdate [lindex $info 4]]
>      $ctext insert end "[mc "Committer"]: [lindex $info 3]  $date\n"
> +    $ctext insert end [lindex $info 8]
>      if {[info exists idtags($id)]} {
>  	$ctext insert end [mc "Tags:"]
>  	foreach tag $idtags($id) {
> 
