From: nguyenki <nguyenki@ensibm.imag.fr>
Subject: Re: [PATCHv1] Export file in git-remote-mediawiki
Date: Sat, 09 Jun 2012 00:59:22 +0200
Message-ID: <c23d4a113c735e093e3e9b06e4f16a70@ensibm.imag.fr>
References: <1339162024-3120-1-git-send-email-nguyenkimthuat@gmail.com>
 <vpqwr3hrj6s.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jun 09 00:59:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd89q-00079T-4l
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 00:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759704Ab2FHW72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 18:59:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45845 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755094Ab2FHW71 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 18:59:27 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q58MoRB3025118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 Jun 2012 00:50:27 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q58MxM87020269;
	Sat, 9 Jun 2012 00:59:22 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q58MxMiV028448;
	Sat, 9 Jun 2012 00:59:22 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q58MxMra028447;
	Sat, 9 Jun 2012 00:59:22 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to nguyenki@ensibm.imag.fr using -f
In-Reply-To: <vpqwr3hrj6s.fsf@bauges.imag.fr>
X-Sender: nguyenki@ensibm.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 09 Jun 2012 00:50:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q58MoRB3025118
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: nguyenki@ensibm.imag.fr
MailScanner-NULL-Check: 1339800629.90272@tgvSRY2A6V6c1iILCGjlBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199541>

On Fri, 08 Jun 2012 16:07:23 +0200, Matthieu Moy wrote:
>> Subject: Re: [PATCHv1] Export file in git-remote-mediawiki
>
> We usually write commit subject lines as "subsystem: description", 
> hence
>
> git-remote-mediawiki: export "File:" attachments
>
Yes, it will be corrected in the next version.

> Kim Thuat NGUYEN <kim-thuat.nguyen@ensimag.imag.fr> writes:
>
>> From: nguyenkimthuat <nguyenkimthuat@gmail.com>
>>
>> This patch adds the functionnality to export the file attachements 
>> from the local git's repository using the API of mediawiki. It also 
>> provides the possibility for
>> an user to delete a page in the local repository Git which means the 
>> page  will be deleted in the wiki site after user do the 'push'.
>
> Please, avoid long lines (> 80 characters).
>
>> +	open(my $g,"-|","git " . $_[0]);
>
> Space after , please.
>
>> +	my %hashFiles = get_file_extensions_maybe($complete_file_name);
>
> What does this function do? My first understanding was that it 
> queried
> the wiki for allowed file extensions, but why does it need the file
> name? It does nothing if $complete_file_name ends with .mw, but then 
> why
> do you run it before entering the following if() statement?
>
>>  	if (substr($complete_file_name,-3) eq ".mw") {
>>  		my $title = substr($complete_file_name,0,-3);
>
  This function will get a list of allowed file extensions. It need the 
file name to verify if this name begins with .mw or not. If not, it does 
nothing like
you said. But if $complete_file_name is not a wiki page (end with .mw), 
the function will return the list of file extensions %hashFiles to 
verify if this file is allowed in this condition:

                              } elsif (exists($hashFiles{$extension})) {


>> @@ -653,39 +666,74 @@ sub mw_push_file {
>>  			# special priviledges. A common
>>  			# convention is to replace the page
>>  			# with this content instead:
>> -			$file_content = DELETED_CONTENT;
>> +			mw_connect_maybe();
>> +			my $re = $mediawiki->edit( {
>> +				action => 'delete',
>> +				title => $title,
>> +				reason => $summary
>> +				} )|| die $mediawiki-> {error}->{code} . ':' . 
>> $mediawiki->{error}->{details};
>
> This is an unrelated topic, and should not appear in this patch.
>
> If you want to propagate page deletions, then you also need to deal 
> with
> the case where the user is not allowed to do so (very common on
> MediaWiki). Also, if you change the code corresponding to the comment
> right above, you should update the comment too.
>
>> +	elsif (exists($hashFiles{$extension}))
>> +	{
>
Yes, i'll correct it in the next patch.
For the moment, i added these lines to deal with the case similar - the 
case when an user tries to upload a file or pages but he doesn't have 
sufficient rights or he failed to login.

+sub error_insufficient_right {
+       print STDERR "Can not delete or upload file and wiki pages\n";
+       print STDERR "You don't have right to do it\n";
+       print STDOUT "error $_[0]\"right insufficient\"\n";
+       return 0;
+}
@@ -726,17 +1011,32 @@ sub mw_push_file {
                                         ignorewarnings=>1,
                                         }, {
                                                   skip_encoding => 1 # 
Helps with names with accentuated characters
-                                               } ) || die $mediawiki-> 
{error}->{code} . ':' . $mediawiki->{error}->{details};
+                                               } );
+                               if (!$res) {
+                                       if ($mediawiki->{error}->{code} 
== 3) {
+                                               # Failed to upload, 
user didn't login or he doesn't have sufficient rights
+                                               print STDERR 'Warning: 
Error ' .
+                                                   
$mediawiki->{error}->{code} .
+                                                   ' from mediwiki: ' 
. $mediawiki->{error}->{details} .
+                                                   ".\n";
+                                               return 
($newrevid,"insufficient-right");
+                                       } else {
+                                               # Other errors. 
Shouldn't happen => just die()
+                                               die 'Fatal: Error ' .
+                                                   
$mediawiki->{error}->{code} .
+                                                   ' from mediwiki: ' 
. $mediawiki->{error}->{details};
+                                       }
+                               }


@@ -860,6 +1161,9 @@ sub mw_push_revision {
                                 # accurate error message.
                                 return error_non_fast_forward($remote);
                         }
+                       if($status eq "insufficient-right") {
+                               return 
error_insufficient_right($remote);
+                       }
                         if ($status ne "ok") {
                                 die("Unknown error from 
mw_push_file()");
                         }



>
>>  	} else {
>>  		print STDERR "$complete_file_name not a mediawiki file (Not 
>> pushable on this version of git-remote-mediawiki).\n"
>>  	}
>
> Isn't the very point of this patch to remove this error message?
Now, the message is
+               print STDERR "$complete_file_name is not a permitted 
file. Check the configuration of file uploads in your mediawiki \n"
+       }


>
>> @@ -825,3 +873,25 @@ sub mw_push_revision {
>>  	print STDOUT "ok $remote\n";
>>  	return 1;
>>  }
>> +
>> +sub get_file_extensions_maybe {
>> +	my $file_name = shift;
>> +	my $est_mw_page = substr($file_name,-3) eq ".mw";
>
> English please. "est" is french ;-).
Corrected.
-       my $est_mw_page = substr($file_name,-3) eq ".mw";
-       if(!$est_mw_page) {
+       my $is_mw_page = substr($file_name,-3) eq ".mw";
+       if(!$is_mw_page) {

Thanks you so much for your advices.

Thuat.
