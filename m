From: Imran M Yousuf <imyousuf@gmail.com>
Subject: Re: [JGit-io-RFC-PATCH v2 2/4] Add JGit IO SPI and default 
	implementation
Date: Tue, 13 Oct 2009 08:30:45 +0700
Message-ID: <7bfdc29a0910121830y4dc9b3efpe17860e04457988d@mail.gmail.com>
References: <1255270073-14205-1-git-send-email-imyousuf@gmail.com>
	 <1255270073-14205-2-git-send-email-imyousuf@gmail.com>
	 <20091012145741.GM9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, egit-dev@eclipse.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 03:37:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxWJz-0002U2-77
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 03:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758646AbZJMBbZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 21:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757361AbZJMBbZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 21:31:25 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:54048 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916AbZJMBbY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 21:31:24 -0400
Received: by vws41 with SMTP id 41so5032713vws.4
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 18:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1G7EAoIsfj8ThgpLmCY2FgPjAwTP6QHFM7kGL+0Y3rI=;
        b=pYWf9kjocWgBLZRiMf9yljo2RzskajhWYZ5ObrbpuKfT6JcCNo5zrWq6CA0uLn2vn9
         dNXA4vw+v3vwdqcz5fzjio66Gozfc8kHIIuOfXUrkXKnqbaeYIKOhzRC976pD0/w5BuR
         BQX2ICVp9DfkNC4ha8+vXyy2oc8QWEisRnp2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RP6wmt4rIjdu3OROVTuJJF4xTtTCiUJm6eHKAbOdUCONkPslSuBF4RWR2I3ItYnM0x
         O6p/4GnseBe7diGS5PErZOMvX2Di3YKaS4BR4GqqKZIeoGbS0YLhy+3kNeQFEevgeoqY
         N9dMF+uyjRei0vZu4R+NnhKwNVYC2aH/ZjM8I=
Received: by 10.220.89.93 with SMTP id d29mr9532748vcm.26.1255397445364; Mon, 
	12 Oct 2009 18:30:45 -0700 (PDT)
In-Reply-To: <20091012145741.GM9261@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130100>

On Mon, Oct 12, 2009 at 9:57 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> imyousuf@gmail.com wrote:
>> The SPI mainly focus's in providing an API to JGit to be able to per=
form
>> similar operations to that of java.io.File. All direct I/O is based =
on the
>> java.io.Input/OutputStream classes.
>>
>> Different JGit IO SPI provider is designed to be URI scheme based an=
d thus
>> the default implementation is that of "file" scheme. SPI provider wi=
ll be
<snip />
> I think this may be a bit in the wrong direction for what we are
> trying to accomplish.
>
> A number of people really want to map Git onto what is essentially
> Google's BigTable schema. =A0Aside from Google's own BigTable product
> (which I want to use Git on at work, because it would vastly simplfiy
> my system administration duties at $DAYJOB) there is Cassandra and
> Hadoop HBase which implement the same schema semantics.
>
> None of those systems implement file streams, they implement cell
> storage in a non-transactional system with a semi-dynamic schema.
>
> Some people have built transactional semantics on top of these
> storage layers, e.g. Google AppEngine provides multiple row
> transactions through some magic sauce layered on top of BigTable.
> I'm sure people will build similar tools on top of Cassandra
> and HBase.
>
> Where I'm trying to go with this is that things that are stored
> in files on the filesystem in traditional Git wouldn't normally be
> mapped into "byte streams" in a BigTable-ish system, or even the
> JDBC-ish system you were describing.
>
> For .git/config we might want to map config variable names into
> keys in the table, with values stored in cells. =A0This makes it
> easier to query or edit the data.
>
> Fortunately, "Config" is abstract enough that we could subclass
> it with a CassandraConfig and simply use that instance when on a
> based Cassandra storage system. =A0No file streams required. =A0Ditto
> for a JdbcConfig.
>

=46irstly, I am sorry but I am not intelligent enough to perceive, how
do the user decide which instance of Config to use? I personally think
that there is no API to achieve what you just mentioned :(; i.e. the
user will have know CassandraConfig directly. Secondly, I instead was
thinking of porting JGit for that matter to any system supporting
streams (not any specific sub-class of them), such HBase/BigTable or
HDFS anything.... Thirdly, I think we actually have several task in
hand and I would state them as -

1. First introduce the I/O API such that it completely replaces java.io=
=2EFile
2. Secondly segregate persistence of for config (or config like
objects) and introduce a SPI for them for smarter storage.

I am not thinking of storing "only" the bare content of a git
repository, but I intent to be able to also store the versioned
contents it self as well. If we choose the above 2 steps I mentioned I
am of the opinion that we will be able
to achieve both our ideas. In addition I hope that if one day Git
itself introduces a similar I/O API then Git can also support the I/O
SPI implementations JGit will.

Waiting eagerly to learn what you think :).

Best regards,

Imran

> For RefDatabase, we'd want to do the same and avoid the concept of
> packed-refs altogether. =A0Each Ref should go into its own row in a
> Cassandra storage system, and essentially act as a loose object.
> Ditto with JDBC.
>
> We'd probably never need to read-or-write the info/refs or
> objects/info/packs listings.
>
> And I think that's everything that a bare repository needs, aside
> from ObjectDatabase, which is already mostly abstract anyway.
>
> --
> Shawn.
>



--=20
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
