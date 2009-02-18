From: Bosko Ivanisevic <bosko.ivanisevic@gmail.com>
Subject: Re: Gforge's cvssh.pl script and git
Date: Wed, 18 Feb 2009 15:31:41 +0100
Message-ID: <2c0671440902180631lbf08d5egb003082a3c683f62@mail.gmail.com>
References: <2c0671440902180124v50570270gc40b745d4a8b1245@mail.gmail.com>
	 <alpine.DEB.1.00.0902181417510.6274@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 15:40:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZnah-0008Cv-Ez
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 15:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbZBROib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 09:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbZBROia
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 09:38:30 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:38641 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbZBROi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 09:38:29 -0500
Received: by bwz5 with SMTP id 5so5507527bwz.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 06:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4rcMf+d5goFEPRtv1XzW/U77K3q/d5gnaUivVz8eyo4=;
        b=ChmKs0cpb3aTE+GfCpj6hbntA4DF5fJF+C9RXovzsBZxe2ooH1XW5Co11K+F0f2eGN
         wb9eOog4h0l/HDO87vWEm+nfKDfHc6bq0s12aIYLr9670y6lhI0Y5MFb5fm3yV8+aL4i
         RxXHdLjEmOjwNWnCGg0VqUY1TPaNLLbzZ+h/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mid1DFGa3KW6Y7xWKDq63GKO078E/XstpqLr0JCVVi30KdqVarirnykrO//4cLjTN4
         M+hDW7dpN7Xt6FydTjBArts00mDjta6pUEURnyort2rx2m8M+nCTmuiqxpiyFporG7A0
         WDY2st7dbQ1VrubyQnZUVihzHT9bSQfSQFFZ0=
Received: by 10.223.122.15 with SMTP id j15mr3174408far.10.1234967502047; Wed, 
	18 Feb 2009 06:31:42 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902181417510.6274@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110547>

Hi,

On Wed, Feb 18, 2009 at 2:24 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 18 Feb 2009, Bosko Ivanisevic wrote:
>
>> In the company I'm working someone has restricted access to all users
>> to only use cvs via cvssh.pl script (source at the end of message)
>> taken from gforge. This script is set as a shell for all users. Now I
>> would like to change it so I can run git too. I've tried by adding
>> 'git', 'git-upload-pack', 'git-receive-pack' and 'git-shell' in the
>> array @allowed_commands. After that if I try to clone existing
>> repository with:
>>
>> git clone ssh://testuser@server_name/tmp/test.git
>>
>> I get following error:
>>
>> fatal: ''/tmp/test.git'': unable to chdir or not a git archive
>> fatal: The remote end hung up unexpectedly
>>
>> I first thought that testuser doesn't have permissions to read
>> directory /tmp/test.git so I changed mode and gave r+w permissions
>> recursively on that folder, but result was same.
>
> r+w?  Not a+rwx?
>
> And only on /tmp/test.git/, or also on /tmp/?
>
> A better way would be to use 'sudo -u testuser git ls-remote
> /tmp/test.git' if sudo is available (you haven't revealed useful
> information about the host).
>

Thanks for your reply. Here are more data. System is SuSe 10.3. On the
test server which has same setup but I can change shell when I change
testuser's shell to /bin/bash I can regularly clone git repository
from remote machine, so all permissions are set correctly. Besides,
output of:

git ls-remote ssh://testuser@server_name:/tmp/test.git

is:

3446c5347e0563cb87e1d8951c57b7f36996f44b        HEAD
3446c5347e0563cb87e1d8951c57b7f36996f44b        refs/heads/master

That leads me to conclusion that perl's exec command makes some mess
which prevents git of running correctly.

>> There is no way I can avoid this perl script (company policy) but I
>> can change it. Problem is that I do not know Perl so much and I do not
>> know what git is exactly doing behind the scene when it is run via
>> ssh.
>
> I'd use 'system("some shell >&2");' to try to debug it.
>
I didn't understand this part. If I change

exec @cmd;

command from perl script to:

system("/bin/bash >&2);

git clone just hangs on the client side. I guess I did something wrong
but don't know what.

Regards,
Bosko
