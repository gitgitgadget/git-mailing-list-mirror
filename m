From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: [RFC] mtn to git conversion script
Date: Sun, 24 Aug 2008 12:18:50 +0300
Message-ID: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, monotone-devel@nongnu.org
X-From: git-owner@vger.kernel.org Sun Aug 24 11:19:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXBlL-0001VQ-62
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 11:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbYHXJSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 05:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbYHXJSv
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 05:18:51 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:55450 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbYHXJSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 05:18:50 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1174841rvb.1
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=0byYbdkDbeMCBsSC1DFdQqJz8Wq5Jm+2963E+/e2x1o=;
        b=lt8sTg96d+TMm6wia3wzDLIw/9y1QEd2AW16kA8sJHyKZVYwrRHn2biGZhN7DfIv2h
         3iNqmhhQC3OdyTkIJE0INhbtFfYmzi4pukh6RO66cuhqzrn/yrCBuofmCq5oaNoTgazA
         k9gssNp9FPZv9yhNUh8vgKod/NNHD1+cI7aEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=gTCEj+tspCbppT9h+hFqIO8oaxt8sH1vHKdJe/MDyHrL00vNMiZjrpRB0pew8b0vzU
         fmwljwQPuyvqZMw0sdln38ptCJJP64PXz4JDWEHDvBp9M7Mi1DBSyd2xOvTspfYTxadF
         c7lmvI0SkLPvoeakpqxqNckYtQ3ul53EMLFco=
Received: by 10.141.1.2 with SMTP id d2mr1502422rvi.42.1219569530206;
        Sun, 24 Aug 2008 02:18:50 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Sun, 24 Aug 2008 02:18:50 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93523>

Hi,

I developed a script that converts a monotone repository into a git
one (exact clone), I want to contribute it so everybody can use it.

However, I might have not done it correctly.

This is the gist of the script:

mtn update --revision #{@id} --reallyquiet
git ls-files --modified --others --exclude-standard -z | git
update-index --add --remove -z --stdin
git write-tree
git write-raw < /tmp/commit.txt
git update-ref refs/mtn/#{@id} #{@git_id}

branches.each do |e|
    git update-ref refs/heads/#{e} #{@git_id}
end

I wrote "git write-raw" which takes the commit text as is, and puts it
into the repository.

I've read about 'fast-import' but I'm not sure if it would be more
efficient, because you would have to parse the output of different mtn
tools.

What do you think? Does it makes sense to have a 'write-raw' command?
Or should I somehow use 'fast-import'?

Best regards.

-- 
Felipe Contreras
